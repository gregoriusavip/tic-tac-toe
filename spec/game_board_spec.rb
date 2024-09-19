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
      it 'return true' do
        position = 3
        expect(filled_board).to be_empty_at(position)
      end
    end

    context 'when a position is not empty' do
      it 'return false' do
        position = 3
        filled_board.update_board(player_one, position)
        expect(filled_board).not_to be_empty_at(position)
      end
    end
  end
end
