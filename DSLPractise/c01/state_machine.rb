# -*- coding: utf-8 -*-

class AbstractEvent
  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end
end

class Event < AbstractEvent
end

class Command < AbstractEvent
end

class Transition
  attr_accessor :source, :target, :trigger

  def initialize(source, target, trigger)
    @source = source
    @target = target
    @trigger = trigger
  end

  def trigger_code
    @trigger.code
  end
end


class StateMachine
  attr_accessor :events, :commands, :states

  def initialize()
    @events = {}
    @commands = {}
    @states = {}
  end

  def add_states(states)
    states.each {|state|
      @states[state.name] = state
    }
  end
end

class State < AbstractEvent
  attr_accessor :name, :actions, :transitions

  def initialize(name)
    @name = name
    @actions = []
    @transitions = {}
  end

  def add_action(command)
    @actions << command
  end

  def add_transition(trigger, target)
    @transitions[trigger] = Transition.new(self, target, trigger)
  end

end
