# frozen_string_literal: true

require_relative('game_controller')

# Class to start the game and keep track scores.
class Game
  GAMEINSTANCE = GameController.new

  def self.play_game
    loop do
      Game::GAMEINSTANCE.start
      Game::GAMEINSTANCE.display_score
      puts 'Do you wanna play again? (input Y|y to continue, otherwise input any key)'
      input = gets
      break unless input.chomp.downcase.eql? 'y'
    end
    puts 'Thank you for playing! :)'
  end
end
