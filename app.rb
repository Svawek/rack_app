require_relative 'time_formatter'

class App

  HEADERS = { 'Content-Type' => 'text/plain' }

  def call(env)
    path = env["REQUEST_PATH"]

    case path
    when '/time'
      time_response(env) 
    else
      not_found_response
    end
  end

  private

  def time_response(env)
    req = Rack::Request.new(env)
    fmt = TimeFormatter.new(req.params['format'].split(','))

    if fmt.valid?
      response(200, ["#{fmt.result} \n"])
    else
      response(400, ["Unknown time format #{fmt.extra_queries}\n"])
    end
  end

  def not_found_response
    response(404, [ "404. No such page!\n" ])
  end

  def response(status, body)
    resp = Rack::Response.new(body, status, HEADERS)
    resp.finish
  end
end
