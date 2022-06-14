# frozen_string_literal: true

class Players
  attr_accessor :stack, :hand

  def initialize(_name)
    @stack = 100
    @hand = Hand.new
  end
end
