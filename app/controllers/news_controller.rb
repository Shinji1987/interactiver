class NewsController < ApplicationController
  require "open-uri"
  def data
    uri = URI.parse('http://newsapi.org/v2/top-headlines?country=jp&apiKey=e4c896666c4749b29910915ece1f9a13')
    json = Net::HTTP.get(uri)
    moments = JSON.parse(json)
    @data = moments['articles'].to_json
  end
end