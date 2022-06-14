# frozen_string_literal: true

module TextUserInterface
  def beginning
    puts 'Это игра в Black Jack'
    puts '======================'
  end

  def name_request
    print 'Введите Ваше имя: '
  end

  def player_greeting
    puts "Привет #{player.name}! Игра начинается!"
  end

  def valid_name
    puts 'У игрока должно быть имя! Попробуй еще раз.'
  end

  def game_over
    puts 'Игра окончена!'
  end

  def player_turn
    puts "#{player.name}, Ваш ход!"
    puts 'пасс | добавить | открыть '
    puts 'Введите команду:'
  end

  def valid_input
    puts 'Такой команты нет! Повторите еще раз.'
  end

  def dealel_turn
    puts 'Дилер сделал свой ход.'
  end

  def three_cards
    puts 'Максимум три карты!'
  end

  def draw
    puts 'Ничья!'
  end

  def won
    puts 'Вы победили!'
  end

  def loss
    puts 'Вы проиграли'
  end

  def play_more
    puts 'Ходите сыграть еще?'
    puts 'да | нет'
  end

  def show_stack
    puts "У Вас в банке #{player.stack}$. В банке дилера #{dealer.stack}$."
  end

  def show_face_of_cards_player
    deck = []
    player.hand.cards.each { |card| deck.push(card.value + card.suit) }
    puts "Ваши карты: #{deck.join(' ')}. Ваши очки: #{player.hand.sum}. Ваш банк: #{player.stack}$)."
  end

  def show_face_of_cards_dealer
    deck = []
    dealer.hand.cards.each { |card| deck.push(card.value + card.suit) }
    puts "Карты дилера #{deck.join(' ')} Очки дилера: #{dealer.hand.sum}. Банк дилера: #{dealer.stack}$)."
  end
end
