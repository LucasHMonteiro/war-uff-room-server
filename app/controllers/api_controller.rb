class ApiController < ApplicationController
  def destroy
    Room.destroy_all
  end
end
