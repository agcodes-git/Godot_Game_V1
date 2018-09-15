extends KinematicBody2D

const boomerang_scene = preload("res://scenes/boomerang/boomerang.tscn")
var mouse_down = false
var boo = null

export var boomerang_velocity = 3000

# For controlling the boomerang.
func _input(event):
	if event.is_pressed() and event is InputEventMouseButton and event.button_index == (BUTTON_LEFT):
		if boo == null:
			boo = boomerang_scene.instance()
			boo.player = self
			
			get_parent().add_child(boo)
			var mouse_position = get_local_mouse_position()
			boo.global_position = global_position
			var direction = (mouse_position).normalized()
			boo.linear_velocity = direction * boomerang_velocity
			
		else: # Allow the player to swap at any time by clicking.
			swap_with_boomerang()
	
func swap_with_boomerang():
	if boo != null:
		global_position = boo.global_position
		boo.queue_free()
		boo = null
