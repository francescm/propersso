class SloController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:back]

  def front
    logger.info("params: #{params}")
    logger.info("session id: #{session.id}")
    session.destroy
    redirect_to(params["return"])
  end

  def back
    logger.info("params: #{params}")
    logger.info("raw post: #{request.raw_post}")
    payload = request.raw_post
    session_id = Nokogiri::XML(payload).xpath('//notify:SessionID', 'notify' => 'urn:mace:shibboleth:2.0:sp:notify').text.strip
    logger.debug session_id

    db_session = Session.where(shib_session: session_id)
    logger.debug db_session
    response_node = if db_session.empty?
                      "<notify:NG/>"
                    else
                      "<notify:OK/>"
                    end
    db_session.first.destroy unless db_session.empty?

    soap = Nokogiri::XML::Builder.new { |xml|
      xml['soap-env'].Envelope('xmlns:soap-env' => 'http://schemas.xmlsoap.org/soap/envelope/', 'xmlns:notify' => 'urn:mace:shibboleth:2.0:sp:notify') do
        xml['soap-env'].Body do
          xml['soap-env'].LogoutNotificationResponse do
            xml << response_node
          end
        end
      end
    }
    soap.to_xml

    logger.debug soap.to_xml
    render xml: soap, content_type: "text/xml"
  end

end
