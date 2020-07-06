extends Node2D

var screen_size = ProjectSettings.get_setting("display/window/size/width")

var Player = preload("res://Entities/Player/Player.tscn")
var Enemy = preload("res://Entities/Enemies/Enemy.tscn")

onready var tilemap = $TileMap
onready var turn_number = 0

# TODO move to a separate file - does Godot have something similar to scriptable objects?
var wall_tile = {"id": 0, "block": 1, "block_view":1}
var grass_tile = {"id": 1, "block": 0, "block_view":0}
var lava_tile = {"id": 2, "block": 1, "block_view":0}

var tiles = []

func _ready():
	randomize()
	set_tiles()
	# instantiate_player(Vector2(0, 0))
	# instantiate_enemy(Vector2(96, 96))
	# instantiate_enemy(Vector2(320, 320))

func instantiate_player(spawn_position) -> void:
	var player = Player.instance()
	player.position = Vector2(spawn_position)
	add_child(player)
	player.connect("player_action", self, "update_world")

func instantiate_enemy(spawn_position) -> void:
	var enemy = Enemy.instance()
	enemy.position = Vector2(spawn_position)
	add_child(enemy)
	enemy.add_to_group("enemies")

func update_world() -> void:
	count_turns()	
	get_tree().call_group("enemies", "enemy_action")

func set_tiles() -> void:
	set_tile(Vector2(12,12), wall_tile)
	set_tile(Vector2(14,12), lava_tile)
	set_tile(Vector2(16,12), grass_tile)

func set_tile(grid_position, tile_type):
	tilemap.set_cellv(grid_position, tile_type.id)
	tiles.append({"coordinates":grid_position, "block": tile_type.block, "block_view":tile_type.block_view})
	
func get_tiles():
	return self.tiles

func count_turns() -> void:
	turn_number += 1
	print("Turn number:" + String(turn_number))

func _input(event):
	if event.is_action_pressed("ui_quit") :
		get_tree().quit()
