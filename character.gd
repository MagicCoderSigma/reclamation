extends CharacterBody2D

# exported to make it accesible via the inspector
@export var movement_speed: float = 250
@export var dash_speed: float = 1000
@export var acceleration: float = 50
@export var breaking: float = 20
@export var gravity: float = 700
@export var jump_force: float = 300

var ability_debounce: bool = true
var ability_in_use: bool = false
var last_input_value_prior_to_ability: float = 0

var move_input: float

@onready var sprite: Sprite2D = $Sprite2D

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _physics_process(delta: float) -> void:
	# apply gravity only on a platform
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# movement input of 1 to -1 (0 is no movement)
	# left is -1
	# right is 1
	move_input = Input.get_axis("left", "right")
	if !ability_in_use:
		last_input_value_prior_to_ability = move_input
	
	if Input.is_action_pressed("ability"):
		if ability_in_use and ability_debounce:
			print("disabling ability")
			ability_in_use = false
			ability_debounce = false
			print("debounce false")
			await wait(1)
			ability_debounce = true
			print("debounce true")
		elif ability_debounce:
			print("activating ability")
			ability_in_use = true
			ability_debounce = false
			await wait(2)
			ability_debounce = true
		else:
			print("cannot activate because of debounce!")
	
	# jumping movement
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = -jump_force # -y to go up because going down means +y
	
	# TODO: naturally decelerate the ability when disabled
	# TODO: disable ability when hitting a wall
	
	if ability_in_use:
		velocity.x = lerp(velocity.x, last_input_value_prior_to_ability * dash_speed, acceleration * 0.01 * delta)
		# process movement
		move_and_slide()
		return
	
	# left and right movement
	# more dynamic movement system
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * movement_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, breaking * delta)
		pass
	
	# process movement
	move_and_slide()

func _process(_delta: float) -> void:
	# if statement here idk why we need cause it works without it but ok
	if velocity.x != 0: 
		sprite.flip_h = velocity.x < 0
