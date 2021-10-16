# frozen_string_literal: true

class Players
  attr_accessor :bank, :hand

  def initialize(_name)
    @bank = 100
    @hand = []
  end

  def add_cards(args)
    hand.push(args)
  end
end
