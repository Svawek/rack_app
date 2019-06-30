class TimeFormatter

  AVAILABLE_TIME_FORMATTE = {
    'year' => "%Y",
    'month'=> "%m",
    'day' => "%d",
    'hour' => "%H",
    'minute' => "%M",
    'second' => "%S"
  }

  def initialize(query)
    @query = query
  end

  def result
    time_format
  end

  def valid?
    extra_queries.empty?
  end

  def extra_queries
    @query - AVAILABLE_TIME_FORMATTE.keys
  end

  private

  def time_format
    format = @query.map { |q| AVAILABLE_TIME_FORMATTE[q] }
    Time.now.strftime(format.join("-"))
  end

end
