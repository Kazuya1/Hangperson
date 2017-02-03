class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(ch)
    if ch==nil || ch.empty? || !ch.match("[a-zA-Z]")
      raise ArgumentError
    end
    ch = ch.downcase
    if(@guesses.include?(ch) || @wrong_guesses.include?(ch))
      return false
    end
    if !@word.include?(ch)
      @wrong_guesses += ch
    else
      @guesses += ch
    end
    return true
  end
  
  def word_with_guesses
    ret = ''
    @word.each_char do |ch|
      ret += @guesses.include?(ch) ? ch : '-'
    end
    return ret
  end
  
  def check_win_or_lose
    if @wrong_guesses.length==7
      return :lose
    end
    if word_with_guesses==@word
      return :win
    end
    return :play
  end
end
