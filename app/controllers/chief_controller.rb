class ChiefController < ApplicationController

  before_action :authenticate_user!

  def create
    redirect_to root_path if !current_user.chief.nil? and return

    chief = Chief.new
    chief.user = current_user
    chief.save

    ChiefResource.create_from_starters chief
    ChiefBuilding.create_from_starters chief

    redirect_to root_path
  end

  def delete
    chief = current_user.chief
    chief.destroy unless chief.nil?

    redirect_to root_path
  end

end
