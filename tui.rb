# frozen_string_literal: true

class TextUserInterface
  attr_accessor :player, :dealer, :cards

  def initialize
    @player = player
    @dealer = dealer
    @cards = cards
  end

  def create_player
    puts "Hi! What's your name?"
    name = gets.chomp
    self.player = User.new(name)
    self.dealer = Dealer.new
    self.cards = PlayingCards.new
  end

  def to_deal_one_card_player
    player.add_cards(cards.deck_of_cards.pop)
  end

  def to_deal_one_card_dealer
    dealer.add_cards(cards.deck_of_cards.pop)
  end

  def to_deal_cards_start
    2.times { to_deal_one_card_player && to_deal_one_card_dealer }
  end

  # def show_face_of_cards
  #  player.hand.each { |cards| puts "#{cards}" }
  # end

  # def show_back_of_card
  #  dealer.hand.each { |cards| puts "**" }
  # end

  def seed
    create_player
    to_deal_cards_start
  end
end
