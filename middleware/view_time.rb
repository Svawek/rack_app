require 'logger'

class ViewTime

  AVAILABLE_QUERIES = %w(year month day hour minute second)

  def initialize(app)
    @app = app
  end

  def call(env)
    @status, headers, @body =  @app.call(env)

    check_request_method(env["REQUEST_METHOD"], env["REQUEST_PATH"], env["QUERY_STRING"])

    [@status, headers, @body]
  end

  private

  def check_request_method(method, path, query)
    check_request_path(path, query)  if method == 'GET'
  end

  def check_request_path(path, query)
    check_query(query) if path == "/time"
  end

  def check_query(query)
    queries = query.delete_prefix("format=").split("%2C")
    extra_queries = queries - AVAILABLE_QUERIES
    if (extra_queries).empty?
      show_time(queries)
    else
      @body = ["Unknown time format #{extra_queries}"]
      @status = 400
    end
  end

  def show_time(queries)
    time = Time.now
    body_time = []
    queries.each do |query|
      case query
      when 'year' then body_time << time.year
      when 'month' then body_time << time.month
      when 'day' then body_time << time.day
      when 'hour' then body_time << time.hour
      when 'minute' then body_time << time.min
      when 'second' then body_time << time.sec
      end
    end

    @body = [ "#{body_time.join("-")}" ]
    @status = 200
  end

end

