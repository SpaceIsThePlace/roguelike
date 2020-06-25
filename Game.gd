extends Node2D

var screen_size = ProjectSettings.get_setting("display/w1indow/size/width")

var Player = preload("res://Entities/Player/Player.tscn")
var Enemy = preload("res://Entities/Enemies/Enemy.tscn")


onready var turn_number = 0

func _ready():
	randomize()
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
	
func _input(event):
	if event.is_action_pressed("ui_quit") :
		get_tree().quit()