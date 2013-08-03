require "rubygems"
require "rack"
require "thin"

rack_app = lambda do |env|
  request = Rack::Request.new(env)
  response = Rack::Response.new
  body = "---------------Header-------------<br/>"
  
  if request.path_info == '/hello'
    body << '<h1>'
    body << "Saying hi "
    client = request['client']
    body << "from #{client}" if client
    body << '</h1>'
  else
    body << "You need to provide the client information"
  end
  body << "<br/>----------footer-----------------"
  response.body = [body]
  response.headers['Content-Length'] = body.bytesize.to_s
  response.headers['Content-Type'] = 'text/html'
  response.to_a
end

Rack::Handler::Thin.run rack_app, :Port => 3005
