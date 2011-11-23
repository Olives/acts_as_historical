class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user

  def set_user
    Thread.current[:current_user] = User.first
  end

end
