extends Node2D

# Design:
	# Five (or whatever) colors which can be set (no-outline style)
	# colors can be set plus contrasting sketchlines / outlines

# TODO: Alter shader to change 5 colors
# TODO: Convert color values to float
# TODO: Concern: Is this method expensive for large number of sprites or colors?

var palette_shader = load("res://shader/color_replace_shader.tres")
var color_counter = 0 # cycle through colors for the demo

 # Dictionary of available color palettes
 # Each palette consists of 5 colors and a constrasting outline color
const cols_available = {
	"default": { # Same as color_keys
		0 : Color(0.37, 0.46, 0.56, 1), # Background
		1 : Color(0.22, 0.22, 0.38, 1), # Background Decor
		2 : Color(0.23, 0.12, 0.17, 1), # Foreground
		3 : Color(1, 0, 0, 1), # Bold accents
		4 : Color(0.86, 0.87, 0.67, 1) # Bold accents 2
	},
	"cream": {
		0: Color(0.86, 0.87, 0.67, 1), # Background
		1: Color(0.37, 0.46, 0.56, 1), # Background Decor
		2: Color(0.23, 0.12, 0.17, 1), # Foreground
		3: Color(0.79, 0.88, 0, 1), # Bold accents
		4: Color(1, 0, 0, 1) # Bold accents 2
	}
}

	# Dictionary describing colors in the asset images
const color_keys = {
	0 : Color(0.37, 0.46, 0.56, 1), # Background
	1 : Color(0.22, 0.22, 0.38, 1), # Background Decor
	2 : Color(0.23, 0.12, 0.17, 1), # Foreground
	3 : Color(1, 0, 0, 1), # Bold accents
	4 : Color(0.86, 0.87, 0.67, 1) # Bold accents 2
}

func _ready():
	# Test: change background color
	$ColorButtons/TestButton.connect("pressed", self, "test_pressed")
	var mat = ShaderMaterial.new()
	mat.set_shader(palette_shader)
	for i in range(5):
		print(i)
		var key_name = "key_" + str(i)
		mat.set_shader_param(key_name, color_keys[i])
	#mat.set_shader_param("key_0", color_keys[0])
	mat.set_shader_param("u_tolerance", 0.1)
	for sprite in $Sprites.get_children():
		var dmat = mat.duplicate(true)
		sprite.set_material(dmat)

func test_pressed():
	print(color_counter)
	if color_counter < 4:
		color_counter += 1
	else:
		color_counter = 0
	for child in $Sprites.get_children():
		for i in range(5):
			child.material.set_shader_param("replacement_" + str(i + color_counter), cols_available["default"][color_counter])
		print(child.material.get_shader_param("replacement_0"))
	#$tester/spin_clean.material.set_shader_param("u_replacement_color", cols_available["default"][color_counter])
	
