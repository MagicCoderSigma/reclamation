extends Node

@onready var horizontal_rooms = [
	[ # INDEX 0 - INDOOR ROOMS
		preload("res://Rooms/horizontal_1.tscn"),
	],
	[ # INDEX 1 - OUTDOOR AREAS
		preload("res://Rooms/horizontal_1.tscn"),
	]
]
@onready var vertical_rooms = [
	[ # INDEX 0 - INDOOR ROOMS
		preload("res://Rooms/vertical_1.tscn"),
	],
	[ # INDEX 1 - OUTDOOR AREAS
		preload("res://Rooms/vertical_1.tscn"),
	]
]

enum RoomType {INSIDE = 0, OUTSIDE = 1}
enum Orientation {HORIZONTAL = 0, VERTICAL = 1}

@onready var Rooms = [
	horizontal_rooms,
	vertical_rooms
]
