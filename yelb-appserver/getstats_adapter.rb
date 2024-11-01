# frozen_string_literal: true

require_relative "modules/getstats"

def getstats_adapter(event:, context:)
  $redishost = ENV["redishost"]
  $port = 6379
  $yelbddbcache = ENV["yelbddbcache"]
  $awsregion = ENV["awsregion"]
  stats = getstats
  # Используйте JSON.parse(stats), если хотите, чтобы API Gateway обрабатывал HTTP-ответы
  # return JSON.parse(stats)
  {
    statusCode: 200,
    body: stats,
    headers: {
      "content_type" => "application/json",
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Headers" => "Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With",
      "Access-Control-Allow-Methods" => "GET,POST,PUT,DELETE,OPTIONS"
    }
  }
end
