# frozen_string_literal: true

class User < Players
  attr_reader :name

  def initialize(name)
    super
    @name = name
    validate!
  end

  protected

  def validate!
    raise if name !~ /.+/
  end
end
