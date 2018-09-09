extends Node

var state = "NO STATE SET"	# The current state of the machine.
var time_in_state = 0	# Time elapsed whilst in the current state.
var priority = 0		# The priority of the current state.

var stateDebugger = null
var animationPlayer = null

func ready():
	self.stateDebugger = get_node("../StateDebugger")
	self.animationPlayer = get_node("../AnimationPlayer")
	
func request_state_change( new_state, new_priority, override_priority ):

	if new_state != self.state and override_priority > self.priority:

		self.time_in_state = 0		
		self.state = new_state
		self.priority = new_priority
				
		if animationPlayer != null:
			if animationPlayer.has_animation(state):
				animationPlayer.play(state)
			else:
				print("Player switched state, but there is no " \
						+ "animation corresponding to the new state.")	
		else:
			print("Failed to find AnimationPlayer: Retrying.")
			animationPlayer = get_node("../AnimationPlayer")
		return true # Successfully switched states.

	return false # Failed to switch to the requested state.
	

func _process(delta):
	time_in_state += delta
	if self.stateDebugger != null:
		self.stateDebugger.text = self.state+"\n" \
			+ str(self.time_in_state)+"\n"+str(self.priority)
	else:
		self.stateDebugger = get_node("../StateDebugger")
			