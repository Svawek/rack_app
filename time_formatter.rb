class TimeFormatter

  AVAILABLE_TIME_FORMATTE = {
    'year' => "%Y",
    'month'=> "%m",
    'day' => "%d",
    'hour' => "%H",
    'minute' => "%M",
    'second' => "%S"
  }

  def initialize(queries)
    @queries = queries.delete_prefix("format=").split("%2C")
  end

  def result
    time_format
    [ "#{@time.join("-")}\n" ]
  end

  def valid?
    extra_queries.empty?
  end

  def extra_queries
    @queries - AVAILABLE_TIME_FORMATTE.keys
  end

  private

  def time_format
    time_now = Time.now
    @time = []
    @queries.each do |query|
      @time << time_now.strftime(AVAILABLE_TIME_FORMATTE[query])
    end
  end

end
