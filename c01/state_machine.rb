# -*- coding: utf-8 -*-

class AbstractEvent
  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end
end

class State < AbstractEvent
end

class Command < AbstractEvent
end

class Transition
end

class StateMachine
end
