extends KinematicBody2D

export (Color) var color # COLOR OF THE TEXT

export (float, 0.0, 1.9) var voice_pitch # HOW HIGH / LOW THE VOICE IS

export (String, FILE) var interaction_script # A JSON DIALOGUE FILE

onready var animation = $sprite

# Disable character collision whenever there is only sideway movement
func _ready():
	if global.get_top_down():
		get_node("body_shape").disabled = false
	else: 
		get_node("body_shape").disabled = true

func talk():
#	print("talking to " + self.name)
	global.set_can_talk(false)
	MSG.start_dialogue(interaction_script, self)





