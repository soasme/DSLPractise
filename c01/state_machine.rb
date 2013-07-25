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

  def add_events(triggers)
    triggers.each { |trigger|
      @events[trigger.name] = trigger
    }
  end

  def add_commands(commands)
    commands.each { |command|
      @commands[command.name] = command
    }
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

  def add_actions(commands)
    commands.each { |command|
      @actions << command
    }
  end

  def add_transitions(dict)
    dict.each { |trigger, target|
      @transitions[trigger] = Transition.new(self, target, trigger)
    }
  end

end

state_machine = StateMachine.new()

door_closed = Event.new(:door_closed, 'D1CL')
drawer_opened = Event.new(:drawer_opened, 'D2OP')
light_on = Event.new(:light_on, 'L1ON')
door_opened = Event.new(:door_opened, 'D1OP')
panel_closed = Event.new(:panel_closed, 'PNCL')
state_machine.add_events([
  door_closed,
  drawer_opened,
  light_on,
  door_opened,
  panel_closed,
])

unlock_panel = Command.new(:unlock_panel, 'PNUL')
lock_panel = Command.new(:lock_panel, 'PNLK')
unlock_door = Command.new(:unlock_door, 'D1UL')
lock_door = Command.new(:lock_door, 'D1LK')
state_machine.add_commands([
  unlock_panel,
  lock_panel,
  unlock_door,
  lock_door,
])

unlocked_pannel = State.new(:unlocked_pannel)
waiting_for_light = State.new(:waiting_for_light)
waiting_for_drawer = State.new(:waiting_for_drawer)
active = State.new(:active)
idle = State.new(:idle)
state_machine.add_states([
  unlocked_pannel,
  waiting_for_light,
  waiting_for_drawer,
  active,
  idle,
])

unlocked_pannel.add_actions([unlock_panel, lock_door])
unlocked_pannel.add_transitions({
  panel_closed => idle
})

waiting_for_light.add_actions({
  light_on => unlocked_pannel
})

waiting_for_drawer.add_transitions({
  drawer_opened => unlocked_pannel
})

active.add_transitions({
  drawer_opened => waiting_for_light,
  light_on => waiting_for_drawer,
})

idle.add_actions([unlock_door, lock_panel])
idle.add_transitions({
  door_closed => active
})

puts state_machine.states.inspect
