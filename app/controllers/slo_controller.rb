class SloController < ApplicationController
  skip_before_action :verify_authenticity_token

  def front
    logger.info("params: #{params}")
    #logger.info("shib session: #{session[:shib_session]}")
    logger.info("session id: #{session.id}")
    session.destroy
    redirect_to(params["return"])
  end

  def back
    logger.info("params: #{params}")
    logger.info("raw post: #{request.raw_post}")
    payload = request.raw_post
    session_id = Nokogiri::XML(payload).xpath('//notify:SessionID', 'notify' => 'urn:mace:shibboleth:2.0:sp:notify').text.strip
    logger.info session_id

    db_session = Session.where(shib_session: session_id)
    logger.info db_session
    db_session.first.destroy unless db_session.empty?

    soap = Nokogiri::XML::Builder.new { |xml|
      xml['soap-env'].Envelope('xmlns:soap-env' => 'http://schemas.xmlsoap.org/soap/envelope/', 'xmlns:notify' => 'urn:mace:shibboleth:2.0:sp:notify') do
        xml['soap-env'].Body do
          xml['soap-env'].LogoutNotificationResponse do
            xml['notify'].OK
          end
        end
      end
    }
    logger.debug soap.to_xml
    render xml: soap, content_type: "text/xml"

  end
end
