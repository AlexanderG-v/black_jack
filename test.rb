class Test

  attr_reader :player, :dealer

  def initialize
    @player = 21
    @dealer = 21 
  end


def counting_results
  if ((player > dealer) && player <= 21) || (player <=21 && dealer > 21)
    puts 'player_won'
  elsif player == dealer || (player >21 && dealer >21)
    puts 'draw'
  else
   puts 'player_loss'
  end
end
end