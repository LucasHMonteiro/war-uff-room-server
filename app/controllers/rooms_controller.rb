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
          'players': @room.players
        }
      }
    end
  end

  def create
    @room = Room.new(code: params[:code], free_space: params[:size])
    @room.save
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
