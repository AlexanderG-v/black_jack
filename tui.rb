# frozen_string_literal: true

class TextUserInterface
  USER_INPUT = {
    'пасс' => :dealer_turn, 'добавить' => :add_a_card,
    'открыть' => :open_cards
  }.freeze

  attr_accessor :player, :dealer, :cards

  def initialize
    @player = player
    @dealer = Dealer.new
    @cards = Deck.new
    create_player
  end

  private

  def create_player
    puts 'Это игра в Black Jack!'
    puts '======================'
    print 'Введите Ваше имя: '
    name = gets.chomp
    self.player = User.new(name)
    puts "Привет #{name}! Игра начинается!"
    beginning_of_game
  rescue RuntimeError
    puts 'У игрока должно быть имя! Попробуй еще раз.'
    retry
  end

  def beginning_of_game
    show_stack
    if player.stack || dealer.stack != 0 # REVIEW
      2.times { to_deal_one_card_player && to_deal_one_card_dealer }
      player.stack -= 10
      dealer.stack -= 10
      counter_hand
      show_face_of_cards_player
      counter_hand
      item_selection
    else
      puts 'Игра окончена!'
      one_more_time
    end
  end

  def player_turn
    puts "#{player.name}, Ваш ход!"
    puts 'пасс | добавить | открыть '
    puts 'Введите команду:'
  end

  def item_selection
    player_turn
    input = gets.chomp
    raise if input !~ /^пасс|добавить|открыть|п$/i

    send(USER_INPUT[input])
  rescue RuntimeError
    puts 'Такой команты нет! Повторите еще раз.'
    retry
  end

  def dealer_turn
    puts 'Дилер сделал свой ход.'
    if dealer.sum <= 17
      to_deal_one_card_dealer
      counter_hand
    end
    show_face_of_cards_dealer
    counting_results
  end

  def add_a_card
    if player.hand.size == 2
      to_deal_one_card_player
      counter_hand
      show_face_of_cards_player
    else
      puts 'Максимум три карты!'
    end
    dealer_turn
  end

  def open_cards
    dealer.hand == 2 if dealer_turn
  end

  def counting_results
    if ((player.sum > dealer.sum) && player.sum <= 21) || (player.sum <= 21 && dealer.sum > 21)
      player.stack += 20
      puts 'Вы победили!'
    elsif player.sum == dealer.sum || (player.sum > 21 && dealer.sum > 21)
      player.stack += 10
      dealer.stack += 10
      puts 'Ничья!'
    else
      dealer.stack += 20
      puts 'Вы проиграли'
    end
    one_more_time
  end

  def one_more_time
    show_stack
    puts 'Ходите сыграть еще?'
    puts 'да | нет'
    input = gets.chomp
    raise if input !~ /^да|нет$/i

    case input
    when 'да' then discard && beginning_of_game
    when 'нет' then exit
    end
  rescue RuntimeError
    puts 'Такой команты нет! Повторите еще раз.'
    retry
  end

  def show_stack
    puts "У Вас в банке #{player.stack}$. В банке дилера #{dealer.stack}$."
  end

  def to_deal_one_card_player
    cards.deck_of_cards.size > 6 ? player.hand.push(cards.deck_of_cards.pop) : to_shuffle_deck
  end

  def to_deal_one_card_dealer
    cards.deck_of_cards.size > 6 ? dealer.hand.push(cards.deck_of_cards.pop) : to_shuffle_deck
  end

  def counter_hand
    player.sum_hand(player.hand)
    dealer.sum_hand(dealer.hand)
  end

  def show_face_of_cards_player
    puts "Ваши карты: #{player.hand.join(' ')} - #{player.sum} points.(Банк #{player.stack}$)."
  end

  def show_face_of_cards_dealer
    puts "Карты дилера #{dealer.hand.join(' ')} - #{dealer.sum} points. (Банк #{dealer.stack}$)."
  end

  def discard
    cards.discard_pile.push(player.hand.slice!(0..-1))
    cards.discard_pile.push(dealer.hand.slice!(0..-1))
  end

  def to_shuffle_deck
    cards.deck_of_cards.push(cards.discard_pile.slice!(0..-1))
  end
end
