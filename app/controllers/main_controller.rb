class MainController < ApplicationController
  def welcome
    @logged_in = session[:uid] ? true: false
    @cn = session[:cn]
  end
end
