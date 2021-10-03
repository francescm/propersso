class SsoController < ApplicationController
  def auth
    sso_data = SsoEnvTranslator.exec(request.env)

    session[:uid] = sso_data[:uid]
    session[:cn] = sso_data[:cn]
    shib_session = sso_data[:shib_session]

    logger.info("Shib-Session-ID as session is #{shib_session}")

    # session.id is cleartext
    logger.debug("session id: #{session.id}")

    private_id = Rack::Session::SessionId.new(session.id.to_s).private_id

    logger.debug("private_session: #{private_id}")

    db_session = Session.find_by_session_id(private_id)
    db_session.shib_session = shib_session
    db_session.save

    redirect_to :controller => 'main', :action => 'welcome'
  end
end
