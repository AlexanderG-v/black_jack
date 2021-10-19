# frozen_string_literal: true

class Deck
  attr_accessor :deck_of_cards, :discard_pile

  SUIT_CARD = ["\u2660", "\u2663", "\u2665", "\u2666"].freeze
  DENOMINATION_CARD = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize
    @deck_of_cards = making_deck_of_cards
    @discard_pile = []
  end

  protected

  def making_deck_of_cards
    deck = []
    DENOMINATION_CARD.each do |value|
      SUIT_CARD.each { |suit| deck << Card.new(value, suit) }
    end
    deck.shuffle!
  end
end
