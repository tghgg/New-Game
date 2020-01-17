extends Node2D

onready var player_comes_out = "res://Dialogues/Game/Player Comes Out.json"
onready var player = $Characters/Player
export (bool) var is_top_down = false
onready var current_scene = self.name

# Setup the scene
func _ready():
	print (current_scene)
	$transition_node.visible = true
	global.set_current_scene(current_scene)
	global.set_top_down(is_top_down)
	global.set_can_talk(true)
	$transition_node.fade_out()
	# use this to replace conditional_branch and choices parsing 

# Method for other nodes to use
func change_scene(scene):
	$transition_node.fade_out()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene(scene)

# Start button
func _on_Start_pressed():
	$transition_node.fade_in()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene("res://Scenes/Intro.tscn")
	pass # Replace with function body.

# Exit button
func _on_Exit_pressed():
	$transition_node.fade_in()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().quit()
	pass # Replace with function body.
