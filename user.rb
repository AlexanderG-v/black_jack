# frozen_string_literal: true

class User < Players
  attr_accessor :name

  def initialize(name)
    super
    @name = name
  end
end
