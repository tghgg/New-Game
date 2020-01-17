extends Node

# signal to handle dialogue events
# just like the old SMRT times
signal dialogue_finished 

# global variables
onready var can_talk = true setget set_can_talk, get_can_talk
onready var current_scene = null setget set_current_scene, get_current_scene
onready var current_body = null setget set_current_body, get_current_body
onready var top_down = false setget set_top_down, get_top_down
# getters and setters

# Top-down movement check getters and setters
func set_top_down(value):
	top_down = value
func get_top_down():
	return top_down

# Dialogue check getters and setters
func set_can_talk(value):
	if value == true:
		# Signal emits whenever a dialogue is finished
		# Used for creating events involving dialogues
		emit_signal("dialogue_finished")
	can_talk = value
func get_can_talk():
	return can_talk

# Current scene check getters and setters 
func set_current_scene(value):
	current_scene = value
func get_current_scene():
	return current_scene


# Current body the player is interacting with check getters and setters 
func set_current_body(value):
	current_body = value
func get_current_body():
	return current_body

# Return the player
func player(): 
	return get_tree().get_root().get_node("%s/Characters/Player" % get_current_scene())