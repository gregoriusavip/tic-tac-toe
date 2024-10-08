# frozen_string_literal: true

require_relative('player')
require_relative('game_board')
require_relative('utility')

# Control the game's logic and loop
class GameController
  PLAYERS = [Player.new('X'), Player.new('O')].freeze

  def initialize(new_board = Board.new)
    @board = new_board
  end

  def start # rubocop:disable Metrics/MethodLength
    turn = 0
    winner = nil
    loop do
      @board.display_board
      puts "\n"
      move(PLAYERS[turn % 2])
      turn += 1
      winner = find_winner
      break if winner
    end
    end_game(winner)
  end

  def display_score
    puts "SCORE [#{PLAYERS[0].name}: #{PLAYERS[0].score}] to [#{PLAYERS[1].name}: #{PLAYERS[1].score}]"
  end

  private

  def move(player)
    puts "Player #{player.name}'s move: (1-9)"
    position = Integer(gets, exception: false)
    until position && (position - 1) >= 0 && @board.empty_at?(position - 1)
      puts "Invalid position. Player #{player.name}'s move:"
      position = Integer(gets, exception: false)
    end
    puts "\n"
    @board.update_board(player, position - 1)
  end

  def find_winner
    winner = Utility.uniq_2d_array(@board.all_horizontal) ||
             Utility.uniq_2d_array(@board.all_vertical) ||
             Utility.uniq_2d_array(@board.all_cross)
    if @board.length == 9
      winner.nil? ? :draw : winner
    else
      winner
    end
  end

  def update_score(player)
    player.score += 1
  end

  def end_game(winner)
    @board.display_board
    puts "\n"
    if winner == :draw
      puts 'Its a tie!'
    else
      puts "The winner is: #{winner.name}!"
      update_score(winner)
    end
    @board = Board.new
  end
end
