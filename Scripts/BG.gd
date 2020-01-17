extends Node2D

# Fade out a child sprite
# Default to a black sprite if there's no argument
func fade_out(scene="transition", time=1.5):
	get_node("fade_out").interpolate_property(get_node(scene), "modulate:a", 1.0, 0.0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	get_node("fade_out").start()

# Fade in a child sprite
# Default to a black sprite if there's no argument
func fade_in(scene="transition", time=1.5):
	if (scene != null):
		get_node(scene).z_index = 0
		get_node("fade_in").interpolate_property(get_node(scene), "modulate:a", 0.0, 1.0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		get_node("fade_in").start()
	
