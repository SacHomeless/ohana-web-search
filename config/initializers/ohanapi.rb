Ohanakapa.configure do |config|
  config.api_token = ENV['OHANA_API_TOKEN'] if ENV['OHANA_API_TOKEN'].present?
  config.api_endpoint = ENV['OHANA_API_ENDPOINT']
end
