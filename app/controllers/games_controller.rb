require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = []
    5.times do
      @grid << ('a'..'z').to_a[rand(26).to_i].upcase!
    end
    @grid
  end

  def score
    @attempt = params[:word]
    @grid = params[:grid]
    validator = 0
    @attempt.split("").each do |l|
      validator = 1 if @grid.gsub(" ", "").downcase!.count(l) < @attempt.count(l)
    end
    # Validar paraula api le wagon (canviar link del @attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    user = JSON.parse(open(url).read)
    # compute score and message
    word_length = @attempt.length
    if validator == 1
      @score = 0
      @message = "Some letters are not in the grid"
    elsif user["found"] == false
      @score = 0
      @message = "not an english word"
    else
      @score = word_length * 500
      @message = "well done"
    end
  end
end
