extends Node

const boomerang_scene = preload("res://scenes/boomerang/boomerang.tscn")
var mouse_down = false
var boo = null

func _input(event):
    if event.is_pressed() and event is InputEventMouseButton and event.button_index == (BUTTON_LEFT):
        if boo == null:
            boo = boomerang_scene.instance()
            get_parent().get_parent().add_child(boo)
            var mouse_position = get_parent().get_local_mouse_position()
            boo.global_position = get_parent().global_position
            var direction = (mouse_position).normalized()
            boo.linear_velocity = direction * 3000
            get_node("Timer").start()

func _on_Timer_timeout():
    get_parent().global_position = boo.global_position
    boo.queue_free()
    boo = null
