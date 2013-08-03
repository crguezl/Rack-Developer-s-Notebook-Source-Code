require "rubygems" 
require "rack"
require "thin"
require 'debugger'

rack_app = lambda do |env|
  request = Rack::Request.new(env)
  if request.path_info == '/guess'
     client = request['client']
     #debugger
     if client && 
        (['safari', 'chrome', 'firefox'].include?  client.downcase)
       [200, {'Content-Type' => 'text/html'}, 
        ["<h1>Good browser: #{client}</h1>"]]
     else
       [200, {}, ["Choose another browser"]]
     end
   else
     [200, {}, ["You have to guess something"]]
   end
 end
 
Rack::Handler::Thin.run rack_app, :Port => 3005
