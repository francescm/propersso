class SsoController < ApplicationController
  def auth
    session[:uid] = request.env["uid"]
    session[:cn] = request.env["cn"]
    session[:shib_session] = request.env["Shib-Session-ID"]

    logger.info session
    logger.info request.env.inspect
    logger.info request.env["Shib-Session-ID"]
    logger.info session[:shib_session]

    redirect_to :controller => 'main', :action => 'welcome'
  end
end
