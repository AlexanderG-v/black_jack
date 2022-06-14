# frozen_string_literal: true

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def sum
    card_names = cards.map(&:value)
    aces = card_names.select { |card| card == 'A' }
    other_cards = card_names.reject { |card| card == 'A' }
    sum = 0
    other_cards.each { |card| sum += card_score(card) }
    aces.each { |_i| sum += (sum + 11) > 21 ? 1 : 11 }
    sum
  end

  def card_score(card)
    card.to_i.zero? ? 10 : card.to_i
  end
end
