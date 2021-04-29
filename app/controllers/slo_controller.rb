class SloController < ApplicationController
  skip_before_action :verify_authenticity_token

  def front
    logger.info("params: #{params}")
    logger.info("shib session: #{session[:shib_session]}")
    logger.info("session id: #{session.id}")
    session.destroy
    redirect_to(params["return"])
  end

  def back
    logger.info("params: #{params}")
    soap = Nokogiri::XML::Builder.new { |xml|
      xml.Envelope('xmlns:soap-env' => 'http://schemas.xmlsoap.org/soap/envelope/', 'xmlns:notify' => 'urn:mace:shibboleth:2.0:sp:notify') do
        xml['soap-env'].Body do
          xml['soap-env'].LogoutNotificationResponse do
            xml['notify'].OK
          end
        end
      end
    }
    render xml: soap

  end
end
