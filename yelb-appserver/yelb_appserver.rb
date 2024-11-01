# frozen_string_literal: true

require "sinatra"
require "aws-sdk-dynamodb"
require_relative "modules/pageviews"
require_relative "modules/getvotes"
require_relative "modules/restaurant"
require_relative "modules/hostname"
require_relative "modules/getstats"
require_relative "modules/restaurantsdbupdate"
require_relative "modules/restaurantsdbread"

disable :protection

configure :production do
  set :redishost, "redis-server"
  set :port, 4567
  set :yelbdbhost, "yelb-db"
  set :yelbdbport, 5432
  set :yelbddbrestaurants, ENV["YELB_DDB_RESTAURANTS"]
  set :yelbddbcache, ENV["YELB_DDB_CACHE"]
  set :awsregion, ENV["AWS_REGION"]
end

configure :test do
  set :redishost, "redis-server"
  set :port, 4567
  set :yelbdbhost, "yelb-db"
  set :yelbdbport, 5432
  set :yelbddbrestaurants, ENV["YELB_DDB_RESTAURANTS"]
  set :yelbddbcache, ENV["YELB_DDB_CACHE"]
  set :awsregion, ENV["AWS_REGION"]
end

configure :development do
  set :redishost, "localhost"
  set :port, 4567
  set :yelbdbhost, "localhost"
  set :yelbdbport, 5432
  set :yelbddbrestaurants, ENV["YELB_DDB_RESTAURANTS"]
  set :yelbddbcache, ENV["YELB_DDB_CACHE"]
  set :awsregion, ENV["AWS_REGION"]
end

configure :custom do
  set :redishost, ENV["REDIS_SERVER_ENDPOINT"]
  set :port, 4567
  set :yelbdbhost, ENV["YELB_DB_SERVER_ENDPOINT"]
  set :yelbdbport, 5432
  set :yelbddbrestaurants, ENV["YELB_DDB_RESTAURANTS"]
  set :yelbddbcache, ENV["YELB_DDB_CACHE"]
  set :awsregion, ENV["AWS_REGION"]
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  halt HTTP_STATUS_OK
end

$yelbdbhost = settings.yelbdbhost
$redishost = settings.redishost
$yelbddbcache = settings.yelbddbcache if settings.yelbddbcache
$yelbddbrestaurants = settings.yelbddbrestaurants if settings.yelbddbrestaurants
$awsregion = settings.awsregion if settings.awsregion

get '/api/pageviews' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  content_type 'application/json'
  @pageviews = pageviews  # Удалены скобки
end

get '/api/hostname' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  content_type 'application/json'
  @hostname = hostname()  # Скобки здесь можно оставить, если метод принимает аргументы
end

get '/api/getstats' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  content_type 'application/json'
  @stats = getstats()
end

get '/api/getvotes' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  content_type 'application/json'
  @votes = getvotes()
end

get '/api/ihop' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  @ihop = restaurantsupdate("ihop")
end

get '/api/chipotle' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  @chipotle = restaurantsupdate("chipotle")
end

get '/api/outback' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  @outback = restaurantsupdate("outback")
end

get '/api/bucadibeppo' do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
  headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
  @bucadibeppo = restaurantsupdate("bucadibeppo")
end
