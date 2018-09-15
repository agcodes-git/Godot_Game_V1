extends StaticBody2D

export var motion = Vector2( 1000, 0 )
export var timer_duration = 1

func _ready():
	get_node("Timer").wait_time = timer_duration
	get_node("Timer").start()
	
func _process( delta ):
	self.position += motion * delta
	
# Flip direction.
func _on_Timer_timeout():
	self.motion = -self.motion
