class SsoController < ApplicationController
  def auth
    session[:uid] = request.env['uid']
    session[:cn] = request.env['cn'].force_encoding('UTF-8')
    session[:shib_session] = request.env['Shib-Session-ID']

    logger.info("Shib-Session-ID as ENV is: #{request.env['Shib-Session-ID']}")
    logger.info("Shib-Session-ID as session is #{session[:shib_session]}")

    redirect_to :controller => 'main', :action => 'welcome'
  end
end
