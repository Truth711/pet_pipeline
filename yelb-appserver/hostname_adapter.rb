# frozen_string_literal: true

require_relative "modules/hostname"

def hostname_adapter(event:, context:)
  hostnamedata = hostname
  # Используйте JSON.parse(hostnamedata), если хотите, чтобы API Gateway обрабатывал HTTP-ответы
  # return hostnamedata
  {
    statusCode: 200,
    body: hostnamedata,
    headers: {
      "content_type" => "application/json",
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Headers" => "Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With",
      "Access-Control-Allow-Methods" => "GET,POST,PUT,DELETE,OPTIONS"
    }
  }
end
