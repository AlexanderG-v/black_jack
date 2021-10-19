# frozen_string_literal: true

require_relative 'modules/module_tui'

class Game
  include TextUserInterface

  USER_INPUT = {
    'пасс' => :dealer_turn, 'добавить' => :add_a_card,
    'открыть' => :open_cards
  }.freeze

  attr_accessor :player, :dealer, :cards

  def initialize
    beginning
    @player = player
    @dealer = Dealer.new
    @cards = Deck.new
    create_player
  end

  private

  def create_player
    name_request
    name = gets.chomp
    self.player = User.new(name)
    player_greeting
    beginning_of_game
  rescue RuntimeError
    valid_name
    retry
  end

  def beginning_of_game
    show_stack
    if (player.stack || dealer.stack) != 0
      2.times { to_deal_one_card_player && to_deal_one_card_dealer }
      player.stack -= 10
      dealer.stack -= 10
      counter_hand
      show_face_of_cards_player
      item_selection
    else
      game_over
      one_more_time
    end
  end

  def item_selection
    player_turn
    input = gets.chomp
    raise if input !~ /^пасс|добавить|открыть|п$/i

    send(USER_INPUT[input])
  rescue RuntimeError
    valid_input
    retry
  end

  def dealer_turn
    dealel_turn
    if dealer.hand.sum <= 17
      to_deal_one_card_dealer
      counter_hand
    end
    show_face_of_cards_dealer
    counting_results
  end

  def add_a_card
    if player.hand.cards.size == 2
      to_deal_one_card_player
      counter_hand
      show_face_of_cards_player
    else
      three_cards
    end
    dealer_turn
  end

  def open_cards
    dealer.hand == 2 if dealer_turn
  end

  def counting_results
    if ((player.hand.sum > dealer.hand.sum) && player.hand.sum <= 21) || (player.hand.sum <= 21 && dealer.hand.sum > 21)
      player.stack += 20
      won
    elsif player.hand.sum == dealer.hand.sum || (player.hand.sum > 21 && dealer.hand.sum > 21)
      player.stack += 10
      dealer.stack += 10
      draw
    else
      dealer.stack += 20
      loss
    end
    one_more_time
  end

  def one_more_time
    show_stack
    play_more
    input = gets.chomp
    raise if input !~ /^да|нет$/i

    case input
    when 'да' then discard && beginning_of_game
    when 'нет' then exit
    end
  rescue RuntimeError
    valid_input
    retry
  end

  def counter_hand
    player.hand.sum
    dealer.hand.sum
  end

  def to_deal_one_card_player
    cards.deck_of_cards.size > 6 ? player.hand.cards.push(cards.deck_of_cards.pop) : to_shuffle_deck
  end

  def to_deal_one_card_dealer
    cards.deck_of_cards.size > 6 ? dealer.hand.cards.push(cards.deck_of_cards.pop) : to_shuffle_deck
  end

  def discard
    cards.discard_pile.push(player.hand.cards.slice!(0..-1))
    cards.discard_pile.push(dealer.hand.cards.slice!(0..-1))
  end

  def to_shuffle_deck
    cards.deck_of_cards.push(cards.discard_pile.slice!(0..-1))
  end
end
