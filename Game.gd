extends Node2D

var screen_size = ProjectSettings.get_setting("display/window/size/width")

var Player = preload("res://Entities/Player/Player.tscn")
var Enemy = preload("res://Entities/Enemies/Enemy.tscn")

onready var tilemap = $TileMap
onready var turn_number = 0

var tiles = [] # TODO 

func _ready():
	randomize()
	tiles = get_tiles()
	instantiate_player(Vector2(0, 0))
	instantiate_enemy(Vector2(96, 96))
	instantiate_enemy(Vector2(320, 320))

func instantiate_player(spawn_position):
	var player = Player.instance()
	player.position = Vector2(spawn_position)
	add_child(player)
	player.connect("player_action", self, "update_world")

func instantiate_enemy(spawn_position):
	var enemy = Enemy.instance()
	enemy.position = Vector2(spawn_position)
	add_child(enemy)
	enemy.add_to_group("enemies")

func update_world():
	count_turns()	
	get_tree().call_group("enemies", "enemy_action")

func count_turns():
	turn_number += 1
	print("Turn number:" + String(turn_number))

func get_tiles(): # TODO change this function to cover all type of tiles
	var cells = tilemap.get_used_cells()
	for cell in cells:
		if tilemap.get_cellv(cell) == 0: # walls have id: 0 - I will need to create a dictionary with all tiles property 
			tiles.append({"coordinates":cell, "block": 1, "block_view":1})
		if tilemap.get_cellv(cell) == 1: # grass/floor have id: 1` 
			tiles.append({"coordinates":cell, "block": 0, "block_view":0})
		elif tilemap.get_cellv(cell) == 2: # lava
			tiles.append({"coordinates":cell, "block": 1, "block_view":0})
	return tiles

func _input(event):
	if event.is_action_pressed("ui_quit") :
		get_tree().quit()
