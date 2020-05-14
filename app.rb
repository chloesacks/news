require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "metric" # or metric, whatever you like
  key = "14fe81fc7e2c5c0a359bf01f7c499c5a" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  ### Get the news
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=761f44092ecb4e9b8d39fd49e530232f"
  @news = HTTParty.get(url).parsed_response.to_hash

  view "news"
end

# puts "It is currently #{forecast["current"]["temp"]} degrees F and #{forecast["current"]["weather"][0]["main"]}"
# puts "Extended forecast:"
# for day in forecast["daily"]
#     puts "A high of #{day["temp"]["max"]}, a low of #{day["temp"]["min"]} and #{day["weather"][0]["main"]}."
# end