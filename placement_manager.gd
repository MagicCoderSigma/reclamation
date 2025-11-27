extends Node2D

var rng = RandomNumberGenerator.new()
@export var room_amount: int = 10
@onready var player: CharacterBody2D = $Player

func generateRoom(room: Node2D = null, specifiedRoom: PackedScene = null, exitPoint: Node2D = null) -> Array:
	# TODO: check exit point supported type to specify what room is needed
	var specifiedExitPoint: Node2D
	
	if !exitPoint:
		specifiedExitPoint = room.get_node("Exit")
	else:
		specifiedExitPoint = exitPoint
	
	var newRoom: Node2D
	
	newRoom = specifiedRoom.instantiate()
	
	add_child(newRoom)
	var offset = newRoom.get_node("Entry").position
	print(specifiedExitPoint)
	newRoom.global_position = specifiedExitPoint.global_position - offset
	
	return [newRoom, newRoom.get_node("Exit")]

func generateRoomGroup(index: int, isFirstRoom: bool, exitPoint: Node2D) -> Array:
	var lastExitPoint: Node2D
	
	if isFirstRoom:
		lastExitPoint = player
	else:
		lastExitPoint = exitPoint
	
	var group: Array = Enums.room_groups[index]
	var result: Array
	var loopedIndex = 0
	
	for room in group:
		result = generateRoom(null, room, lastExitPoint)
		loopedIndex += 1
		
		if loopedIndex == 1 and isFirstRoom:
			result[0].position = player.position
		
		lastExitPoint = result[1]
	return result

func randomRoomGeneration(origin: Node2D, placementAmount: int, roomGroup: Array, placeRoomsOnce: bool = true) -> Array:
	var roomAmount = roomGroup.size()
	
	var indexes = []
	var newIndex = rng.randi_range(0, roomAmount - 1)
	indexes.append(newIndex)
	var results = generateRoom(origin, roomGroup[newIndex])
	origin = results[0]
	
	for i in range(placementAmount):
		var passes = false
		while passes == false:
			
			newIndex = rng.randi_range(0, roomAmount - 1)
			if indexes.find(newIndex) and !placeRoomsOnce:
				continue
			indexes.append(newIndex)
			passes = true
		
		results = generateRoom(origin, roomGroup[newIndex])
		origin = results[0]
		
	return results
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# create room instance
	var result = generateRoomGroup(0, true, null) # intro
	result = randomRoomGeneration(result[0], 15, Enums.room_groups[2], false) # lobby place
	result = generateRoomGroup(1, false, result[1]) # hcontainment entrance
