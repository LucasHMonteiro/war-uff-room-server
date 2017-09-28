#!/usr/bin/python3
import urllib
import socket
from http.server import BaseHTTPRequestHandler, HTTPServer
import time
from cgi import parse_header, parse_multipart
import random
import string

hostName = "127.0.0.1"
hostPort = 80

rooms = {}

def random_hash(length):
    pool = string.hexdigits[:16]
    return ''.join(random.choice(pool) for i in range(length))

def create_room(code, size):
	global rooms
	rooms[code] = {'players':[], 'free_space': size}


class MyServer(BaseHTTPRequestHandler):

	def create_room(size):
		global rooms
		code = binascii.hexlify(os.urandom(5))
		rooms[code] = {'players':[], 'free_space': size}

	def do_GET(self):
		self.send_response(200)
		self.wfile.write(bytes(str(size), "utf-8"))

	def post_params(self):
		ctype, pdict = parse_header(self.headers['content-type'])
		params = {}
		if ctype == 'application/x-www-form-urlencoded':
			length = int(self.headers['content-length'])
			params = urllib.parse.parse_qs(self.rfile.read(length), keep_blank_values=1)
		return params

	def do_POST(self):
		global rooms
		params = self.post_params()
		new_room_b = str.encode('new_room')
		new_player_b = str.encode('new_player')
		room_b = str.encode('room')
		if new_room_b in params.keys():
			code = random_hash(5)
			size = int(params[new_room_b][0])
			create_room(code, size)
		if new_player_b in params.keys():
			room = params[room_b][0].decode('utf-8')
			if rooms[room]['free_space'] > 0:
				player = params[new_player_b][0].decode('utf-8')
				rooms[room]['players'].append(player)
				rooms[room]['free_space'] -= 1 
		print(rooms)

myServer = HTTPServer((hostName, hostPort), MyServer)
print(time.asctime(), "Server Starts - %s:%s" % (hostName, hostPort))

try:
	myServer.serve_forever()
except KeyboardInterrupt:
	pass

myServer.server_close()
print(time.asctime(), "Server Stops - %s:%s" % (hostName, hostPort))
