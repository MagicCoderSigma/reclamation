extends Node

@onready var room_groups = [
	[
		preload("res://Rooms/introductory_room.tscn"),
		preload("res://Rooms/elevator_shaft.tscn"),
	],
	[
		preload("res://Rooms/hcontain_fromlobby_1.tscn"),
		preload("res://Rooms/hcontain_fromlobby_1_2.tscn"),
		preload("res://Rooms/hcontain_entry.tscn"),
	],
	[
		preload("res://Rooms/lobby_1.tscn"),
		preload("res://Rooms/lobby_1_2.tscn"),
		preload("res://Rooms/lobby_2.tscn"),
		preload("res://Rooms/lobby_2_2.tscn"),
		preload("res://Rooms/lobby_2_3.tscn"),
	]
]

enum RoomType {INSIDE = 0, OUTSIDE = 1}
enum Orientation {HORIZONTAL = 0, VERTICAL = 1}
