class NewsController < ApplicationController
  require "open-uri"

  before_action :authenticate_user!
  
  def data
    uri = URI.parse("http://newsapi.org/v2/top-headlines?country=jp&category=business&apiKey=#{ENV["NEWS_API_KEY"]}")
    json = Net::HTTP.get(uri)
    moments = JSON.parse(json)
    @data = moments['articles'].to_json
  end
end