class SsoController < ApplicationController
  def auth
    session[:uid] = request.env['uid']
    session[:cn] = request.env['cn'].force_encoding('UTF-8')
    shib_session = request.env['Shib-Session-ID']

    logger.info("Shib-Session-ID as ENV is: #{request.env['Shib-Session-ID']}")
    logger.info("Shib-Session-ID as session is #{shib_session}")

    # session.id is cleartext
    # session.session_id is crypted
    logger.info("session id: #{session.id}")
    logger.info("session_id: #{session['session_id']}")
    logger.info("serialize: #{::Base64.encode64(Marshal.dump(session.id))}")
    public_session_id = cookies['_session_id']
    private_id = Rack::Session::SessionId.new(public_session_id).private_id
    logger.info("public_session_id: #{public_session_id}")
    logger.info("private_session: #{private_id}")


    #db_session = Session.find_by_session_id(session.session_id)
    #db_session.shib_session = shib_session
    #db_session.save

    redirect_to :controller => 'main', :action => 'welcome'
  end
end
