class GamesController < ApplicationController
  require "json"
  require "open-uri"

  def new
    @letters = Array.new(20) { ('A'..'Z').to_a.sample }
  end

  def score
    guess = params[:word]
    if legal?(guess)
      if exist?(guess)
        @score = guess.split('').length
        @message = "Congratulations"
      else
        @score = 0
        @message = "This word doesn't have the right letters"
      end
    else
      @score = 0
      @message = "This word doesn't exist"
    end
  end

  def exist?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def legal?(word)
    word.upcase.split('').all? { |letter| params[:my_letters].include?(letter) }
  end
end
