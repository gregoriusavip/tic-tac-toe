# frozen_string_literal: true

require_relative('player')
require_relative('game_board')
require_relative('utility')

# Control the game's logic and loop
class GameController
  def start
    turn = 0
    winner = nil
    loop do
      GameController::BOARD.display_board
      move(GameController::PLAYERS[turn % 2])
      turn += 1
      winner = find_winner
      break if winner
    end
    update_score(winner) unless winner == :draw
  end

  def display_score
    puts "SCORE #{PLAYERS[0]}: #{PLAYERS[0].score} to #{PLAYERS[1]}: #{PLAYERS[1].score}"
  end

  private

  PLAYERS = [Player.new('X'), Player.new('O')].freeze
  BOARD = Board.new

  def move(player)
    puts "Player #{player.name}'s move: (0-9)"
    position = Integer(gets, exception: false)
    until position && BOARD.empty_at?(position)
      puts "Invalid position. Player #{player.name}'s move:"
      position = Integer(gets, exception: false)
    end
    GameController::BOARD.update_board(player, position)
  end

  def find_winner
    winner = Utility.uniq_2d_array(GameController::BOARD.all_horizontal) ||
             Utility.uniq_2d_array(GameController::BOARD.all_vertical) ||
             Utility.uniq_2d_array(GameController::BOARD.all_cross)
    if GameController::BOARD.length == 9
      winner.nil? ? :draw : winner
    else
      winner
    end
  end

  def update_score(player)
    player.score += 1
  end
end
