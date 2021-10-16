# frozen_string_literal: true

class Dealer < Players
  attr_reader :name

  def initialize(name = 'Diler')
    super
    @name = 'Dealer'
  end
end
