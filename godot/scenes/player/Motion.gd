extends Node

var motion = Vector2(0,0)
const UP = Vector2(0,-1)
var player = null
        
func _physics_process(delta):
    if self.player == null: self.player = get_parent()

    apply_gravity(delta)
    update_input()
    self.motion = self.player.move_and_slide( self.motion, UP )
    
func apply_gravity(delta): 
    self.motion.y += 6000 * delta

func update_input():
    if Input.is_action_pressed("ui_up") and self.player.is_on_floor():
        motion.y = -2500
        
    if Input.is_action_pressed("ui_right"): motion.x = 1000
    elif Input.is_action_pressed("ui_left"): motion.x = -1000
    else: motion.x = 0
    
