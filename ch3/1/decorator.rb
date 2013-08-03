class Decorator
  def initialize(app)
    @app = app
  end
  def call(env)
    status, headers, body = @app.call(env)
    new_body = "-----------Header-------------<br/>"
    body.each { |str| new_body << str }
    new_body << "<br/>--------Footer--------------"
    # headers['Content-Length'] = new_body.bytesize.to_s
    headers['Content-type'] = 'text/html'
    [status, headers, [new_body]]
  end
end
