extends RigidBody2D

var player = null

func _ready():
	self.contact_monitor = true
	self.contacts_reported = 2

# Add time (1/2 a second) before the forced teleport for each collision.
func _on_Node2D_body_entered(body):
	print(player.get_node("Timer").time_left)
	player.get_node("Timer").wait_time = player.get_node("Timer").time_left + 0.5
	player.get_node("Timer").stop()
	player.get_node("Timer").start()