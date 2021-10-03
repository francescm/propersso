
module SsoEnvTranslator

  def self.exec(env)
    response = {}

    fields = %w{uid cn}

    Rails.logger.info("Shib-Session-ID as ENV is: #{env['Shib-Session-ID']}")
    fields.each do |field|
      # if rails is exposed to shibboleth-sp directly trought apache's mod_passenger ...
      if env[field]
        response[field.to_sym] = env[field].force_encoding(Encoding::UTF_8)
        # if there is areverse proxy, like in functional tests ...
      elsif env["HTTP_#{field.upcase}"]
        response[field.to_sym] = env["HTTP_#{field.upcase}"].force_encoding(Encoding::UTF_8)
      else
        Rails.logger.error "Missing shib attr #{field}"
        unless Rails.env.eql? "development"
          raise RuntimeError, "Unavailable authentication service"
        end

      end
    end
    response[:shib_session] = env['Shib-Session-ID']
    return response
  end

end
