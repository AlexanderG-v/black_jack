hand=["6♦", "10♣","Q♥", "A♥"]


#cards = hand.map { |card| card[0...-1]}
#pictures = cards.select {|card| card == "A" }

#print cards
#print pictures


class Hand
  attr_accessor :hand

  def initialize(hand)
    @hand = hand
  end

  def calculate
    card_names = @hand.map { |card| card[0...-1] }
    aces = card_names.select { |card| card == "A" }
    other_cards = card_names.reject { |card| card == "A" }
    score = 0

    other_cards.each { |card| score += card_score(card) }
    aces.each { |_i| score += (score + 11) > 21 ? 1 : 11 }

    score
  end

  #def add_card(card)
   # @cards << card
  #end


  def card_score(card)
    card.to_i.zero? ? 10 : card.to_i
  end
end


