class Connection
  def self.get(url, app_id, symbol)
    uri = URI("#{url}app_id=#{app_id}&symbols=#{symbol}")
    Net::HTTP.get_response(uri)
  end
end
