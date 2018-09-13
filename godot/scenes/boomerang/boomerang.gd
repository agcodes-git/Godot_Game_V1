extends RigidBody2D

var player = null

export var initial_teleport_time = 0.5
export var additional_teleport_time = 0.5

func _ready():
	self.contact_monitor = true
	self.contacts_reported = 2
	self.player.get_node("Timer").wait_time = initial_teleport_time

# Add time (1/2 a second) before the forced teleport for each collision.
func _on_Node2D_body_entered(body):
	print(player.get_node("Timer").time_left)
	player.get_node("Timer").wait_time = player.get_node("Timer").time_left + additional_teleport_time
	player.get_node("Timer").stop()
	player.get_node("Timer").start()