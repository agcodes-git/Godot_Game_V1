extends Node

var motion = Vector2(0,0)
const UP = Vector2(0,-1)
var player = null

export var gravity_accel = 6000
export var jump_impulse = 2500
export var movement_vel = 1000

func _physics_process(delta):
    if self.player == null: self.player = get_parent()

    apply_gravity(delta)
    update_input()
    self.motion = self.player.move_and_slide( self.motion, UP )
    
func apply_gravity(delta): 
    self.motion.y += gravity_accel * delta

func update_input():
    if Input.is_action_pressed("ui_up") and self.player.is_on_floor():
        motion.y = -jump_impulse
        
    if Input.is_action_pressed("ui_right"): motion.x = movement_vel
    elif Input.is_action_pressed("ui_left"): motion.x = -movement_vel
    else: motion.x = 0
    
