extends Node2D

# Design:
	# Five (or whatever) colors which can be set (no-outline style)
	# colors can be set plus contrasting sketchlines / outlines

# TODO: Alter shader to change 5 colors
# TODO: Concern: Is this method expensive for large number of sprites or colors?

const palette_shader = preload("res://shader/color_replace_shader.tres")
var color_counter = 0 # cycle through colors for the demo

 # Dictionary of available color palettes
 # Each palette consists of 5 colors and a constrasting outline color
const cols_available = {
	"default": { # Same as color_keys
		0 : Color(95, 117, 142), # Background
		1: Color(56, 57, 97), # Background Decor
		2: Color(59, 31, 43), # Foreground
		3: Color(255, 0, 0), # Bold accents
		4: Color(219, 223, 172) # Bold accents 2
	},
	"cream": {
		0: Color(219, 223, 172), # Background
		1: Color(95, 117, 142), # Background Decor
		2: Color(59, 31, 43), # Foreground
		3: Color(201, 225, 0), # Bold accents
		4: Color(255, 0, 0) # Bold accents 2
	}
}

	# Dictionary describing colors in the asset images
const color_keys = {
	0 : Color(95, 117, 142), # Background
	1 : Color(56, 57, 97), # Background Decor
	2 : Color(59, 31, 43), # Foreground
	3 : Color(255, 0, 0), # Bold accents
	4 : Color(219, 223, 172) # Bold accents 2
}

func _ready():
	# Test: change background color
	$ColorButtons/TestButton.connect("pressed", self, "test_pressed")
	var mat = ShaderMaterial.new()
	mat.set_shader(palette_shader)
	mat.set_shader_param("u_color_key", color_keys[0])
	for sprite in $Sprites.get_children():
		sprite.set_material(mat)

func test_pressed():
	var a
	# set shader param
	#$Sprites/moving_platfom.material.set_shader_param("u_color_key", Color(95,93,92))
	a = color_counter
	print(a)
	if color_counter < 4:
		color_counter += 1
	else:
		color_counter = 0
	for child in $Sprites.get_children():
		child.material.set_shader_param("u_replacement_color", cols_available["default"][color_counter])
		print(child.material.get_shader_param("u_color_key"))
		print(child.material.get_shader_param("u_replacement_color"))
	$tester/spin_clean.material.set_shader_param("u_replacement_color", cols_available["default"][color_counter])
	
