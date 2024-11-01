# frozen_string_literal: true

require_relative "modules/restaurant"

def restaurant_adapter(event:, context:)
  $yelbdbhost = ENV["yelbdbhost"]
  $yelbdbport = 5432
  $yelbddbrestaurants = ENV["yelbddbrestaurants"]
  $awsregion = ENV["awsregion"]
  restaurantname = event["pathParameters"]["restaurant"]
  restaurantcount = restaurantsupdate(restaurantname)
  # Используйте JSON.parse(restaurantcount), если хотите, чтобы API Gateway обрабатывал HTTP-ответы
  # return JSON.parse(restaurantcount)
  {
    statusCode: 200,
    body: restaurantcount,
    headers: {
      "content_type" => "application/json",
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Headers" => "Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With",
      "Access-Control-Allow-Methods" => "GET,POST,PUT,DELETE,OPTIONS"
    }
  }
end
