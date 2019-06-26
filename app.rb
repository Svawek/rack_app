require_relative 'time_formatter'

class App

  HEADERS = { 'Content-Type' => 'text/plain' }

  def call(env)
    [@status, HEADERS, body(env)]
  end

  private

  def body(env)
    if check_request_method?(env["REQUEST_METHOD"]) & check_request_path?(env["REQUEST_PATH"])
      fmt = TimeFormatter.new(env["QUERY_STRING"])

      if fmt.valid?
        @status = 200
        fmt.result
      else
        @status = 400
        ["Unknown time format #{fmt.extra_queries}\n"]
      end

    else
      @status = 404
      [ "404. No such page!\n" ]
    end
  end

  def check_request_method?(method)
    method == 'GET'
  end

  def check_request_path?(path)
    path == "/time"
  end

end
