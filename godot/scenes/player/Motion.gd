extends Node

var motion = Vector2(0,0)
const UP = Vector2(0,-1)
var player = null

export var gravity_accel = 6000
export var jump_impulse = 2500
export var movement_vel = 1000

var colliding = false
var ray = null

func _process(delta):
	if self.player == null: self.player = get_parent()	
	if self.ray == null: self.ray = get_node("../RayCast2D")
	apply_gravity(delta)
	update_input()
	move_with_platform(delta)	
	
	self.motion = self.player.move_and_slide( self.motion, UP )
	
	# Move by the motion vector given by the platform, but halve the y-component.
	# I noticed the player bouncing on the upward motion and thought it might be overshooting. For
	# whatever reasons, diving by 2 appears to work.
	if colliding and ray.get_collider().is_in_group("moving_platforms"):
		self.motion = player.move_and_slide( Vector2(ray.get_collider().motion.x, ray.get_collider().motion.y/2) )
		#self.motion = player.move_and_slide( ray.get_collider().motion )
    
func move_with_platform(delta):
	
	# For debugging (on landing).
	#if not colliding and ray.is_colliding(): 
	#	print(ray.get_collider().is_in_group("moving_platform"))
	
	colliding = ray.is_colliding()
	
func apply_gravity(delta): 
	if not(colliding and ray.get_collider().is_in_group("moving_platforms")):
    	self.motion.y += gravity_accel * delta

func update_input():
	if Input.is_action_pressed("ui_up") and (self.player.is_on_floor() or (colliding and ray.get_collider().is_in_group("moving_platforms"))):
		motion.y = -jump_impulse
        
	if Input.is_action_pressed("ui_right"): motion.x = movement_vel
	elif Input.is_action_pressed("ui_left"): motion.x = -movement_vel
	else:
			 motion.x = 0
    
