class TimeFormatter

  AVAILABLE_TIME_FORMATTE = {
    year: "%Y",
    month: "%m",
    day: "%d",
    hour: "%H",
    minute: "%M",
    second: "%S"
  }

  def initialize(queries)
    @queries = queries
  end

  def result
    time_format
    [ "#{@time.join("-")}" ]
  end

  private

  def time_format
    time_now = Time.now
    @time = []
    @queries.each do |query|
      @time << time_now.strftime(AVAILABLE_TIME_FORMATTE[query.to_sym])
    end
  end

end
