extends Node2D

var rng = RandomNumberGenerator.new()
@export var room_amount: int = 10
@onready var player: CharacterBody2D = $Player


func generateRoom(room: Node2D) -> Node2D:
	# TODO: check exit point supported type to specify what room is needed
	var exitPoint = room.get_node("Exit")
	# select room category (orientation and type)
	var roomOrientation = room.exitPointOrientation
	var roomExitType = room.exitToRoomType
	var possibleExitRooms = Enums.Rooms[roomOrientation][roomExitType]
	
	# get a random index
	var index = rng.randi_range(0, possibleExitRooms.size()-1)
	# use that index to get the room
	var newRoom: Node2D = possibleExitRooms[index].instantiate()
	add_child(newRoom)
	
	var entryPoint = newRoom.get_node("Entry")
	var offset = entryPoint.position
	
	newRoom.global_position = exitPoint.global_position - offset
	return newRoom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get the position of the player
	var player_position = player.position
	# create room instance
	var room: Node2D = Enums.Rooms[0][0][0].instantiate()
	add_child(room)
	# place room to player position
	room.position = player_position
	
	for i in range(room_amount):
		print("Room "+str(i+1)+" instantiating... ")
		room = generateRoom(room)
