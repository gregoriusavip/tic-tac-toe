# frozen_string_literal: true

require_relative '../lib/game_board'
require_relative '../lib/player'

describe Board do
  describe '#update_board' do
    subject(:empty_board) { described_class.new }

    let(:player_one) { instance_double(Player) }

    context 'when the board is empty' do
      it 'puts a player object on a given position' do
        position = 3
        expect { # rubocop:disable Style/BlockDelimiters
          empty_board.update_board(player_one, position)
        }.to change { empty_board.instance_variable_get(:@board)[position] }.from(nil).to(player_one)
      end

      it 'increments the length of the board' do
        position = 3
        expect { # rubocop:disable Style/BlockDelimiters
          empty_board.update_board(player_one, position)
        }.to change { empty_board.instance_variable_get(:@length) }.by(1)
      end
    end
  end

  describe '#empty_at?' do
    subject(:filled_board) { described_class.new }

    let(:player_one) { instance_double(Player) }

    context 'when a position is empty' do
      it 'returns true' do
        position = 3
        expect(filled_board).to be_empty_at(position)
      end
    end

    context 'when a position is not empty' do
      it 'returns false' do
        position = 3
        filled_board.update_board(player_one, position)
        expect(filled_board).not_to be_empty_at(position)
      end
    end
  end

  describe '#all_horizontal' do
    subject(:horizontal_board) { described_class.new }

    let(:player_one) { instance_double(Player) }

    context 'when the board is filled' do
      it 'returns the correct horizontal sequence' do
        horizontal_sequence = [[player_one, nil, nil], [nil, player_one, nil], [nil, nil, player_one]]
        horizontal_board.update_board(player_one, 0)
        horizontal_board.update_board(player_one, 4)
        horizontal_board.update_board(player_one, 8)
        expect(horizontal_board.all_horizontal).to eq(horizontal_sequence)
      end
    end
  end

  describe '#all_vertical' do
    subject(:vertical_board) { described_class.new }

    let(:player_one) { instance_double(Player) }

    context 'when the board is filled' do
      it 'returns the correct vertical sequence' do
        vertical_sequence = [[player_one, player_one, nil], [nil, nil, nil], [nil, nil, player_one]]
        vertical_board.update_board(player_one, 0)
        vertical_board.update_board(player_one, 3)
        vertical_board.update_board(player_one, 8)
        expect(vertical_board.all_vertical).to eq(vertical_sequence)
      end
    end
  end

  describe '#all_cross' do
    subject(:cross_board) { described_class.new }

    let(:player_one) { instance_double(Player) }

    context 'when the board is filled' do
      it 'returns the correct cross sequence' do
        cross_sequence = [[player_one, nil, player_one], [nil, nil, nil]]
        cross_board.update_board(player_one, 0)
        cross_board.update_board(player_one, 3)
        cross_board.update_board(player_one, 8)
        expect(cross_board.all_cross).to eq(cross_sequence)
      end
    end
  end
end
