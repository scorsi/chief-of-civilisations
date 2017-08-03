class BuildingController < ApplicationController

  before_action :authenticate_user!
  before_action :check_chief

  def index
  end

  def show
    @building = get_chief_building_by_name params[:name]
    return redirect_to building_path if @building.nil?
    @building_tier = @building.upgrade_require_resource
  end

  def upgrade
    @building = get_chief_building_by_name params[:name]
    @building.upgrade
    redirect_to building_show_path @building.name
  end

  def collect
    @building = get_chief_building_by_name params[:name]
    @building.collect
    redirect_to building_show_path @building.name
  end

  private

  def check_chief
    @chief = current_user.chief
    redirect_to root_path if @chief.nil?
  end

  def get_chief_building_by_name(name)
    @chief.buildings.each do |building|
      return building if building.name == name
    end
    nil
  end

end