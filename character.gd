extends CharacterBody2D

# exported to make it accesible via the inspector
@export var movement_speed: float = 250
@export var acceleration: float = 50
@export var breaking: float = 20
@export var gravity: float = 500
@export var jump_force: float = 250

var move_input: float

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# apply gravity only on a platform
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# movement input of 1 to -1 (0 is no movement)
	# left is -1
	# right is 1
	move_input = Input.get_axis("ui_left", "ui_right")
	print(move_input)
	
	# left and right movement
	# more dynamic movement system
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * movement_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, breaking * delta)
		pass
	
	# snappy movement (old)
	# velocity.x = move_input * movement_speed
	
	# jumping movement
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force # -y to go up because going down means +y
		
	# process movement
	move_and_slide()

func _process(_delta: float) -> void:
	if velocity.x != 0: # if statement here idk why we need cause it works without it but ok
		sprite.flip_h = velocity.x < 0
