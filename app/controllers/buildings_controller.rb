class BuildingsController < ApplicationController
  def index
    @buildings = AbstractBuilding.all
  end

  def show
    @building = AbstractBuilding.find_by_main_name params[:name]
    redirect_to buildings_index_path if @building.nil?
  end
end
