class SsoController < ApplicationController
  def auth
    ENV["uid"] = "tizio"
    ENV["cn"] = "Tizio"
    session[:uid] = ENV["uid"]
    session[:cn] = ENV["cn"]
    session[:shib_session] = ENV["Shib-Session-ID"]
    redirect_to :controller => 'main', :action => 'welcome'
    logger.info session
    logger.info ENV.inspect
    logger.info ENV["Shib-Session-ID"]
    logger.info session[:shib_session]
  end
end
