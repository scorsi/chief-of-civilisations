class HomeController < ApplicationController

  before_action :authenticate_user!, only: [:overview]

  def index
    redirect_to overview_path if user_signed_in?
  end

  def overview
    @chief = current_user.chief
  end
end
