require "rubygems"
require "rack"
require "thin"
require 'debugger'

rack_app = lambda do |env|
  debugger
  request = Rack::Request.new(env)
  response = Rack::Response.new
  
  if request.path_info == '/redirect'
    response.redirect("http://google.com")
  else
    response.headers['Content-Type'] = "text/plain"
    response.write "<h1>You did not get redirected</h1>"
  end
  response.finish
end

Rack::Handler::Thin.run rack_app, :Port => 3005
