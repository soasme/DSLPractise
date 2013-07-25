# -*- coding: utf-8 -*-

class AbstractEvent
  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end
end

class State < AbstractEvent
  attr_accessor :name, :actions, :transitions

  def initialize(name)
    @name = name
    @actions = []
    @transitions = {}
  end

  def add_actions(*commands)
    puts commands
    commands.each { |command|
      @actions << command
    }
  end

  def add_transitions(dict)
    dict.each { |key, value|
      @transitions[key] = value
    }
  end
end

class Command < AbstractEvent
end

class Transition
end

class StateMachine
end
