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
          'name': @player.name,
          'attributes': @player.additional_info
        }
      }
    end
  end

  def create
    respond_to do |format|
      if @room.players.size < @room.free_space
        @room.players.build(name: params[:name], identity: params[:identity])
        @room.save
        format.json { head :no_content }
      else
        format.json { render json: 'Room is full' }
      end
    end
  end

  def update
    respond_to do |format|
      if @player
        @player.additional_info = params[:attributes]
        @player.save
        format.json { head :no_content }
      else
        format.json { render json: 'Player doesn\'t exist. Like your future' }
      end
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_player
      @player = Player.find_by(identity: params[:identity])
    end

    def set_room
      @room = Room.find_by(code: params[:room_code])
    end

end
