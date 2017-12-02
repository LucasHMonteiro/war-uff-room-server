class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
    respond_to do |format|
      format.json { render json: @rooms }
    end
  end

  def show
    respond_to do |format|
      format.json {
        render json: {
          'code': @room.code,
          'size': @room.free_space,
          'players': @room.players.each_with_object({}) { |player, hash|
            hash["#{player.id}"] = { 'name': player.name, 'attributes': player.additional_info }
          }
        }
      }
    end
  end

  def create
    @room = Room.new(code: params[:code], free_space: params[:size])
    @room.save
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_room
      @room = Room.find_by(code: params[:code])
    end

end
