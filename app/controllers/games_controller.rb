require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    p letters = params[:letters]
    p word = params[:score]
    if wordincluded?(letters, word) == false
      @reply = "Sorry this word doesn't exists"
    elsif checkword?(word) == false && wordincluded?(letters, word) == true
      @reply = 'Sorry this is not a valid English word'
    elsif checkword?(word) && wordincluded?(letters, word)
      @reply = 'Congratulations'
    end
  end

  def checkword?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response_serialized = URI.open(url).read
    response = JSON.parse(response_serialized)
    response[:found]
  end

  def wordincluded?(letters, word)
    letters.join("").upcase.include?(word.upcase)
  end
end
