# -*- coding: utf-8 -*-

load 'state_machine.rb'

def event(name, code)
  Event.new(name, code)
end

def command(name, code)
  Command.new(name, code)
end

def state(name, &block)
  puts name, block
end

event :door_closed, 'D1CL'
event :drawer_opened, 'D2OP'
event :light_on, 'L1ON'
event :door_opened, 'D1OP'
event :panel_closed, 'PNCL'

command :unlock_panel, 'PNUL'
command :lock_panel, 'PNLK'
command :unlock_door, 'D1UL'
command :lock_door, 'D1LK'

state :unlocked_pannel do
  actions :unlock_panel, :lock_door
  transitions :panel_closed => :idle
end

state :waiting_for_light do
  transitions :light_on => :unlocked_pannel
end

state :waiting_for_drawer do
  transitions :drawer_opened => :unlocked_pannel
end

state :idle do
  actions :unlock_door, :lock_panel
  transitions :door_opened => :active
end

state :active do
  transitions :drawer_opened => :waiting_for_light, :light_on => :waiting_for_drawer
end
