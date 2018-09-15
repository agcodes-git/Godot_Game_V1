extends RigidBody2D

var player = null

export var initial_teleport_time = 0.5
export var additional_teleport_time = 0.5

func _ready():
	self.contact_monitor = true
	self.contacts_reported = 2
	get_node("Timer").wait_time = initial_teleport_time
	get_node("Timer").start()
	print("ready")

# Add time (1/2 a second) before the forced teleport for each collision.
func _on_Node2D_body_entered(body):
	get_node("Timer").wait_time = get_node("Timer").time_left + additional_teleport_time
	get_node("Timer").stop()
	get_node("Timer").start()

func _on_Timer_timeout():
	player.swap_with_boomerang()
