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
    self.cards = Deck.new
  end

  def to_deal_one_card_player
    player.add_cards(cards.deck_of_cards.pop)
  end

  def to_deal_one_card_dealer
    dealer.add_cards(cards.deck_of_cards.pop)
  end

  def beginning_of_game
    if player.stack || dealer.stack != 0 # REVIEW
      2.times { to_deal_one_card_player && to_deal_one_card_dealer }
      player.bet && dealer.bet
    else
      puts 'gggg'
    end
  end

  def counter_hand
    player.sum_hand(player.hand)
    dealer.sum_hand(dealer.hand)
  end

  def show_face_of_cards_player
    puts "#{player.hand.join(' ')} - #{player.sum} points <- #{player.name}."
  end

  def show_face_of_cards_dealer
    puts "#{dealer.hand.join(' ')} - #{dealer.sum} points <- Dealer."
  end

  def seed
    create_player
    beginning_of_game
    counter_hand
  end
end
