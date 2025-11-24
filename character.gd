extends CharacterBody2D

# exported to make it accesible via the inspector
@export var movement_speed: float = 250
@export var acceleration: float = 50
@export var breaking: float = 20
@export var gravity: float = 500
@export var jump_force: float = 250
@export var dash_power: float = 25000

var ability_available: bool = true
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
	
	# left and right movement
	# more dynamic movement system
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * movement_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, breaking * delta)
		pass
	
	# jumping movement
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = -jump_force # -y to go up because going down means +y
	
	# dashing movement
	if Input.is_action_pressed("ability"):
		if ability_available == true:
			ability_available = false
			velocity.x += dash_power * move_input 
			await wait(2)
			ability_available = true
			print("We are back online!")
		
	# process movement
	move_and_slide()

func _process(_delta: float) -> void:
	# if statement here idk why we need cause it works without it but ok
	if velocity.x != 0: 
		sprite.flip_h = velocity.x < 0
