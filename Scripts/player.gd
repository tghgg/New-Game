extends KinematicBody2D

# Export key variables for easy editing 
export (Color) var color # COLOR OF THE TEXT

export (float, 0.0, 1.9) var voice_pitch # HOW HIGH / LOW THE VOICE IS

export (String, FILE) var interaction_script # A JSON DIALOGUE FILE

# Initialize variables
onready var motion = Vector2(0, 0)
const ACCELERATION = 300
const MAX_SPEED = 500
const GRAVITY = lerp(1400, 3000, 0.9)
const JUMP = 800
onready var animation = $sprite
onready var area = $interactable_area

# Initializeer
# Connect the interactable area for interaction functions
func _ready():
	print(interaction_script)
	area.connect("area_entered", self, "_on_interactable_area_area_entered")
	area.connect("area_exited", self, "_on_interactable_area_area_exited")
	self.connect("tree_exited", self, "clear_dependencies")


# Dialogue handler
func talk():
#	print("talking to " + self.name)
	global.set_can_talk(false)
	MSG.start_dialogue(interaction_script, self)


# Interaction with NPCs and objects handler
func _on_interactable_area_area_entered(body):
	print(body)
	global.set_current_body(body)
	global.set_can_talk(true)
func _on_interactable_area_area_exited(body):
	global.set_current_body(null)

# Input handler
func _physics_process(delta):
	# Check whether player is in dialogue
	# If in dialogue then freeze all movement until dialogue is finished
	if global.get_can_talk():
		# Interaction Input
		if Input.is_action_just_pressed("interact") and global.get_current_body() != null and self.is_on_floor():
			# get the parent of the area2d which is the Kinematic2D node and use the talk() method
			global.get_current_body().get_parent().talk()

		# Movement Input
		motion.x = 0
		# Sideway motion
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			animation.play("walking")
			animation.flip_h = false	
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			animation.play("walking")
			animation.flip_h = true
		else:
			motion.x = lerp(motion.x, 0.0, 0.2)
			animation.play('idle')

		# Jump function 
		if self.is_on_floor():
			# Important
			# Leave motion.y at 90 
			# Setting at 0 won't do much harm but it causes the player's body to jiggle when walking down slopes
			motion.y = 90
			if Input.is_action_pressed("ui_up"):
				motion.y -= JUMP
		else:
			# Apply gravity
			motion.y += delta * GRAVITY

		# check for top-down movement 
		if global.get_top_down(): 
			if Input.is_action_pressed("ui_up"):
				motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
				animation.play("walking")
			elif Input.is_action_pressed("ui_down"):
				motion.y = min(motion.y + ACCELERATION, MAX_SPEED)
				animation.play("walking")
			else:
				#motion.x = lerp(motion.x, 0, 0.2)   adds a bit of inertia when stopped
				motion.y = 0
#		else: 
			# Apply gravity
#			motion.y += lerp(100, 500, 0.2)
#			motion.y += delta * GRAVITY
#		if (motion == Vector2(0,0)):
#			animation.play('idle') 
			
	else:
		motion = Vector2(0, 0)	
		animation.play('idle')
		
	# move with 'motion' speed, the up direction is y=1, and stop on slopes
#	move_and_slide_with_snap(motion, Vector2(0, 1), Vector2(0, -1), true)
	move_and_slide(motion, Vector2(0, -1), true)

# Clear signal connections when the scene ends
func clear_dependencies():
	area.disconnect("area_entered", self, "_on_interactable_area_area_entered")
	area.disconnect("area_exited", self, "_on_interactable_area_area_exited")