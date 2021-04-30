class SsoController < ApplicationController
  def auth
    session[:uid] = request.env['uid']
    session[:cn] = request.env['cn'].force_encoding('UTF-8')
    shib_session = request.env['Shib-Session-ID']

    logger.info("Shib-Session-ID as ENV is: #{request.env['Shib-Session-ID']}")
    logger.info("Shib-Session-ID as session is #{shib_session}")
    logger.info("session id: #{session.id}")

    db_session = Session.find(session.id)
    db_session.shib_session = shib_session
    db_session.save

    redirect_to :controller => 'main', :action => 'welcome'
  end
end
