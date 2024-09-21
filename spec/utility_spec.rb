# frozen_string_literal: true

require_relative '../lib/utility'

describe Utility do
  describe 'self.uniq_2d_array' do
    context 'when a 2d array contains an array of only unique elements' do
      it 'returns the unique element' do
        unique_2d_array = [[1, 0], [0, 1], [0, 0]]
        expect(described_class.uniq_2d_array(unique_2d_array)).to eq(0)
      end
    end

    context 'when a 2d array contains no unique elements' do
      it 'returns nil' do
        non_unique_array = [[1, 0], [0, 1], [0, 2]]
        expect(described_class.uniq_2d_array(non_unique_array)).to be_nil
      end
    end

    context 'when the unique element is nil' do
      it 'returns nil' do
        nil_unique = [[1, 0], [0, 1], [nil, nil]]
        expect(described_class.uniq_2d_array(nil_unique)).to be_nil
      end
    end

    context 'when the array is not a 2d array' do
      it 'expects undenifed method error' do
        non_2d = [1, 1]
        expect { described_class.uniq_2d_array(non_2d) }.to raise_error(NoMethodError)
      end
    end
  end
end
