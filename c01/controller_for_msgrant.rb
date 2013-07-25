# -*- coding: utf-8 -*-

load 'state_machine.rb'

state_machine = StateMachine.new()

door_closed = Event.new(:door_closed, 'D1CL')
drawer_opened = Event.new(:drawer_opened, 'D2OP')
light_on = Event.new(:light_on, 'L1ON')
door_opened = Event.new(:door_opened, 'D1OP')
panel_closed = Event.new(:panel_closed, 'PNCL')

unlock_panel = Command.new(:unlock_panel, 'PNUL')
lock_panel = Command.new(:lock_panel, 'PNLK')
unlock_door = Command.new(:unlock_door, 'D1UL')
lock_door = Command.new(:lock_door, 'D1LK')

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

unlocked_pannel.add_action unlock_panel
unlocked_pannel.add_action lock_door
unlocked_pannel.add_transition panel_closed, idle

waiting_for_light.add_transition light_on, unlocked_pannel

waiting_for_drawer.add_transition drawer_opened, unlocked_pannel

active.add_transition drawer_opened, waiting_for_light
active.add_transition light_on, waiting_for_drawer

idle.add_action unlock_door
idle.add_action lock_panel
idle.add_transition door_closed, active

puts state_machine.states.inspect
