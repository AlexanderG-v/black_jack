# frozen_string_literal: true

class Players
  attr_accessor :stack, :hand, :sum

  def initialize(_name)
    @stack = 100
    @hand = []
    @sum = 0
  end

  def sum_hand(hand)
    card_names = hand.map { |card| card[0...-1] }
    aces = card_names.select { |card| card == 'A' }
    other_cards = card_names.reject { |card| card == 'A' }
    self.sum = 0
    other_cards.each { |card| self.sum += card_score(card) }
    aces.each { |_i| self.sum += (self.sum + 11) > 21 ? 1 : 11 }
  end

  def card_score(card)
    card.to_i.zero? ? 10 : card.to_i
  end
end
