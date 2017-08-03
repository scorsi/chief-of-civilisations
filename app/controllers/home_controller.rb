class HomeController < ApplicationController

  before_action :authenticate_user!, only: [:private]

  def index
    return unless user_signed_in?
    @chief = current_user.chief
    render file: 'home/private', content_type: 'text/html'
  end

end
