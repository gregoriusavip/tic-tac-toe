# frozen_string_literal: true

require_relative '../lib/game_controller'
require_relative '../lib/game_board'
require_relative '../lib/utility'

describe GameController do
  # rubocop:disable RSpec/SubjectStub
  describe '#start' do
    subject(:game_start) { described_class.new(board) }

    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:display_board)
      allow($stdout).to receive(:puts)
      allow(game_start).to receive(:move)
      allow(game_start).to receive(:end_game)
    end

    context 'when a winner is found after one move' do
      it 'ends the game after moving once' do
        allow(game_start).to receive(:find_winner).and_return(true)
        game_start.start
        expect(game_start).to have_received(:move).once
      end
    end

    context 'when a winner is found after two moves' do
      it 'ends the game after moving twice' do
        allow(game_start).to receive(:find_winner).and_return(nil, true)
        game_start.start
        expect(game_start).to have_received(:find_winner).twice
      end
    end

    context 'when it takes 9 moves to determine a winner' do
      it 'sends display_board 9 times' do
        move_returns = Array.new(8)
        move_returns << true
        allow(game_start).to receive(:find_winner).and_return(*move_returns)
        game_start.start
        expect(board).to have_received(:display_board).exactly(9).times
      end
    end

    context 'when player_one fills the board horizontally' do
      player_one = 'X'
      before do
        allow(board).to receive(:all_horizontal)
        allow(board).to receive(:length)
        allow(Utility).to receive(:uniq_2d_array).and_return(player_one)
      end

      it 'ends the game with player_one as the winner' do
        game_start.start
        expect(game_start).to have_received(:end_game).with(player_one).once
      end
    end

    context 'when player_one fills the board vertically' do
      player_one = 'X'
      before do
        allow(board).to receive(:all_horizontal)
        allow(board).to receive(:all_vertical)
        allow(board).to receive(:length)
        allow(Utility).to receive(:uniq_2d_array).and_return(player_one)
      end

      it 'ends the game with player_one as the winner' do
        game_start.start
        expect(game_start).to have_received(:end_game).with(player_one).once
      end
    end

    context 'when player_one wins fills the board diagonally' do
      player_one = 'X'
      before do
        allow(board).to receive(:all_horizontal)
        allow(board).to receive(:all_vertical)
        allow(board).to receive(:all_cross)
        allow(board).to receive(:length)
        allow(Utility).to receive(:uniq_2d_array).and_return(player_one)
      end

      it 'ends the game with player_one as the winner' do
        game_start.start
        expect(game_start).to have_received(:end_game).with(player_one).once
      end
    end

    context 'when 9 turns have passed and no winner has been found' do
      before do
        allow(board).to receive(:all_horizontal)
        allow(board).to receive(:all_vertical)
        allow(board).to receive(:all_cross)
        allow(board).to receive(:length).and_return(9)
        allow(Utility).to receive(:uniq_2d_array).and_return(nil)
      end

      it 'ends the game with a draw' do
        game_start.start
        expect(game_start).to have_received(:end_game).with(:draw).once
      end
    end
  end
  # rubocop:enable RSpec/SubjectStub
end
