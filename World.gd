extends Node2D

onready var turn_number = 0

func _ready():
	instantiate_player()

func count_turns():
	turn_number += 1
	print(turn_number)
	
func instantiate_player():
	var Player = preload("res://Player/Player.tscn")
	var player = Player.instance()
	player.position = Vector2(64, 64)
	add_child(player)
	player.connect("player_action", self, "count_turns")
