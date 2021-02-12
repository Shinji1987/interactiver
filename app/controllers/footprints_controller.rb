class FootprintsController < ApplicationController

  def index
    @footprints = Footprint.where(visited_user_id: current_user.id).order('created_at DESC')    
  end

end
