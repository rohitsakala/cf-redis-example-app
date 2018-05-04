require 'sinatra'
require 'redis'
require 'cf-app-utils'

get '/:key' do
  value = redis_client.get(params[:key])
  if value
    status 200
    body value
  else
    status 404
    body 'key not present'
  end
end



def redis_client
  @client ||= Redis.new(
    url: "rediss://asdf.foo.dev:6380",
    ssl_params: {
      ca_file: "/Users/pivotal/workspace/redis-stunnel-test-keys/ca.pem"
    },
    timeout: 3000
  )
end
