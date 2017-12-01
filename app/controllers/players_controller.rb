class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_room

  def index
    respond_to do |format|
      format.json { render json: @room.players }
    end
  end

  def show
    respond_to do |format|
      format.json {
        render json: {
          "#{@player.id}": {
            'name': @player.name,
            'attributes': @player.additional_info
          }
        }
      }
    end
  end

  def create
    respond_to do |format|
      if @room.players.size < @room.free_space
        @room.players.build(name: params[:name])
        @room.save
        format.json { head :no_content }
      else
        format.json { render json: 'Room is full' }
      end
    end
  end

  def update
    @player.additional_info = params[:attributes]
    @player.save
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def set_room
      @room = Room.find_by(code: params[:room_code])
    end

end
