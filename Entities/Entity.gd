extends Node2D

class_name Entity

export var grid_position:Vector2
export var color = (Color(0, 0, 0, 0))

var tile_size = 32
var can_move = true
var planned_grid_position = Vector2.ZERO

#### TODO Change how checking collision with walls works
# Not very efficient to have a copy of all the walls for each entity, but for now it will do
# Might be better to create a function in Game that checks the next tile type
onready	var game = get_tree().get_root().get_node("Game")
onready var tiles = game.get_tiles() 
		
func move(movement:Vector2):
	planned_grid_position.x = grid_position.x + movement.x
	planned_grid_position.y = grid_position.y + movement.y
	for tile in tiles:
		if tile.block == 1 && planned_grid_position.x == tile.coordinates.x && planned_grid_position.y == tile.coordinates.y:
			can_move = false
			break
	if can_move:
		set_grid_position(planned_grid_position)	
	position = grid_position * tile_size
	can_move = true
	
func get_grid_position():
	return grid_position
	
func set_grid_position(new_position:Vector2):
	grid_position = new_position
	
