class SloController < ApplicationController
  def front
    logger.info("params: #{@params}")
    logger.info("shib session: #{session[:shib_session]}")
    logger.info("session id: #{session.id}")
    session.destroy
    redirect_to(@params["return"])
  end

  def back
    logger.info("params: #{@params}")
  end
end
