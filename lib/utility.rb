# frozen_string_literal: true

# Utility helper methods
class Utility
  def self.uniq_2d_array(array)
    array.each do |i|
      return i[0] if i.uniq.length == 1 && !i.nil?
    end
    nil
  end
end
