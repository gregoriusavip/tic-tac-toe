# frozen_string_literal: true

# Manage creation and information of a tic-tac-toe board.
class Board
  def initialize
    @board = Array.new(9)
  end

  def update_board(player, position)
    @board[position] = player
  end

  def display_board
    @board.each_with_index do |player, index|
      player.nil? ? (print '_') : (print player.name)
      ((index + 1) % 3).zero? ? (print "\n") : (print ' ')
    end
  end

  def empty_at?(position)
    !!@board[position]
  end
end
