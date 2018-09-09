extends Node

#------------------------------------------
# NOT FOR INTENDED USE IN THE GAME.
#------------------------------------------
# This code only serves an an illustration 
# of one way to use the state manager.
#------------------------------------------

var stateManager = null

func _ready():
	self.stateManager = get_node("../StateManager")
	
func _input(event):
	if self.stateManager == null: return
	
	self.stateManager.request_state_change("IDLE", 0, 1)
	if Input.is_action_just_pressed("ui_up"): self.stateManager.request_state_change("UP_STATE", 2, 2)
	if Input.is_action_just_pressed("ui_down"): self.stateManager.request_state_change("DOWN_STATE", 2, 2)
	if Input.is_action_just_pressed("ui_accept"): self.stateManager.request_state_change("SPACE_STATE", 1, 3)
	
func _process(delta):
	
	if (self.stateManager.state == "UP_STATE" or \
		self.stateManager.state == "DOWN_STATE") \
		and self.stateManager.time_in_state > 1.0:
			
		self.stateManager.request_state_change("IDLE", 0, 3)
		