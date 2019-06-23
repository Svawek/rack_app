class App

  def call(env)
    [status, headers, body]
  end

  private

  def status
    404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    [ "404. No such page!\n" ]
  end

end
