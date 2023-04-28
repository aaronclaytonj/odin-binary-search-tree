# frozen_string_literal: true

class Node
  attr_reader :data
  attr_accessor :left, :right

  def initialize(value = nil, left = nil, right = nil)
    @data = value
    @left = left
    @right = right
  end
end
