require_relative 'time_formatter'

class App

  AVAILABLE_QUERIES = %w(year month day hour minute second)

  def call(env)
    status(env)
    [@answer_status, headers, body]
  end

  private

  def status(env)
    if check_request_method?(env["REQUEST_METHOD"]) & check_request_path?(env["REQUEST_PATH"])
      if check_query?(env["QUERY_STRING"])
        @answer_status = 200
      else
        @answer_status = 400
      end
    else
      @answer_status = 404
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    if @answer_status == 200
      fmt = TimeFormatter.new(@queries)
      fmt.result
    elsif @answer_status == 400
      ["Unknown time format #{@extra_queries}"]
    else
      [ "404. No such page!\n" ]
    end
  end

  def check_request_method?(method)
    method == 'GET'
  end

  def check_request_path?(path)
    path == "/time"
  end

  def check_query?(query)
    @queries = query.delete_prefix("format=").split("%2C")
    @extra_queries = @queries - AVAILABLE_QUERIES
    (@extra_queries).empty?
  end

end
