# frozen_string_literal: true

# Player's information
class Player
  attr_reader :name
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = 0
  end
end
