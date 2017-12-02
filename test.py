#!/usr/bin/python3
import urllib
import socket
from http.server import BaseHTTPRequestHandler, HTTPServer
import time
from cgi import parse_header, parse_multipart
import random
import string
import json

hostName = "127.0.0.1"
hostPort = 80

rooms = {}

def string_params(params):
	for key in params:
		params[key.decode('utf-8')] = params.pop(key)
	return params

def create_room(params):
	global rooms
	code = params['code'][0].decode('utf-8');
	size = int(params['new_room'][0])
	rooms[code] = {'players':[], 'free_space': size}

def get_room(code):
	return rooms[code]

def add_player(params):
	global rooms
	room = params['room'][0].decode('utf-8')
	if rooms[room]['free_space'] > 0:
		player = params['new_player'][0].decode('utf-8')
		rooms[room]['players'].append(player)
		rooms[room]['free_space'] -= 1

class RoomServer(BaseHTTPRequestHandler):

	def get_params(self):
		path = self.path
		params = urllib.parse.parse_qs(path[2:])
		return params

	def do_GET(self):
		params = self.get_params()
		room = get_room(params['room'][0])
		self.send_response(200)
		self.send_header("Content-type", "text/xml")
		self.send_header('Access-Control-Allow-Origin','*')
		self.end_headers()
		self.wfile.write(bytes(json.dumps(room), "utf-8"))

	def post_params(self):
		ctype, pdict = parse_header(self.headers['content-type'])
		params = {}
		if ctype == 'application/x-www-form-urlencoded':
			length = int(self.headers['content-length'])
			params = urllib.parse.parse_qs(self.rfile.read(length), keep_blank_values=1)
		return params

	def do_POST(self):
		params = string_params(self.post_params())
		if 'new_room' in params.keys():
			create_room(params)
		if 'new_player' in params.keys():
			add_player(params)
		self.send_response(200);
		print(rooms)

	def do_DELETE(self):
		pass

room_server = HTTPServer((hostName, hostPort), RoomServer)
print(time.asctime(), "Server Starts - %s:%s" % (hostName, hostPort))

try:
	room_server.serve_forever()
except KeyboardInterrupt:
	pass

room_server.server_close()
print(time.asctime(), "Server Stops - %s:%s" % (hostName, hostPort))
