extends Node2D

const TILE_SIZE = 32

var screen_width = ProjectSettings.get_setting("display/window/size/width")
var screen_height = ProjectSettings.get_setting("display/window/size/height")
var map_width = screen_width / TILE_SIZE
var map_height = screen_height / TILE_SIZE

var Player = preload("res://Entities/Player/Player.tscn")
var Enemy = preload("res://Entities/Enemies/Enemy.tscn")

onready var tilemap = $TileMap
onready var turn_number = 0

# TODO move to a separate file - does Godot have something similar to scriptable objects?
var tiles = [
	{"name": "wall_tile", "id": 0, "block": 1, "block_view":1},
	{"name": "grass_tile", "id": 1, "block": 0, "block_view":0},
	{"name": "lava_tile", "id": 2, "block": 1, "block_view":0},
	{"name": "floor_tile", "id": 3, "block": 0, "block_view":0}
]

# TODO simple test room
var room1 = {x = 5, y = 5, width = 6, height = 4} # TODO transform to class?
var room2 = {x = 12, y = 12, width = 6, height = 6}

func _ready():	
	randomize()
	set_map()
	instantiate_player(Vector2( 7 * TILE_SIZE, 7 * TILE_SIZE))
	# instantiate_enemy(Vector2(96, 96))
	# instantiate_enemy(Vector2(320, 320))

func update_world() -> void:
	count_turns()	
	get_tree().call_group("enemies", "enemy_action")

func set_map() -> void:	
	for x in range(0, map_width ):
		for y in range(0, map_height):
			tilemap.set_cellv(Vector2(x, y), 0)
	create_room(room1)
	create_room(room2)
	pass
	
func create_room(room) -> void:
	for x in range(room.x + 1, room.x + room.width):
		for y in range(room.y + 1, room.y + room.height):
			tilemap.set_cellv(Vector2(x, y), 1)
		
func is_blocked(grid_position):
	var cell_id = tilemap.get_cell(grid_position.x, grid_position.y)
	return tiles[cell_id].block

func _input(event):
	if event.is_action_pressed("ui_quit") :
		get_tree().quit()
		
func instantiate_player(spawn_position) -> void:
	var player = Player.instance()
	player.position = Vector2(spawn_position.x, spawn_position.y)
	add_child(player)
	player.grid_position = spawn_position / TILE_SIZE # Initial player position in the grid
	player.connect("player_action", self, "update_world")

func instantiate_enemy(spawn_position) -> void:
	var enemy = Enemy.instance()
	enemy.position = Vector2(spawn_position)
	add_child(enemy)
	enemy.add_to_group("enemies")

func count_turns() -> void:
	turn_number += 1
	print("Turn number:" + String(turn_number))
