# frozen_string_literal: true

# Manage creation and information of a tic-tac-toe board.
class Board
  attr_reader :length

  def initialize
    @board = Array.new(9)
    @length = 0
  end

  def update_board(player, position)
    @board[position] = player
    @length += 1
  end

  def display_board
    @board.each_with_index do |player, index|
      player.nil? ? (print '_') : (print player.name)
      ((index + 1) % 3).zero? ? (print "\n") : (print ' ')
    end
  end

  def empty_at?(position)
    @board.fetch(position, false).nil?
  end

  def all_horizontal
    [@board[0, 3], @board[3, 3], @board[6, 3]]
  end

  def all_vertical
    vertical = []
    3.times do |i|
      temp = []
      3.times do |j|
        temp.push(@board[3 * j + i])
      end
      vertical.push(temp)
    end
    vertical
  end

  def all_cross
    cross = []
    2.times do |i|
      temp = []
      3.times do |j|
        temp.push(@board[i * 2 + j * 4 / (i + 1)])
      end
      cross.push(temp)
    end
    cross
  end
end
