extends Node2D

class_name Entity

const TILE_SIZE = 32
var grid_position:Vector2
export var color = (Color(0, 0, 0, 0))

var can_move = true
var planned_grid_position = Vector2.ZERO

#### TODO Change how checking collision with walls works
onready	var game = get_tree().get_root().get_node("Game")

func move(movement:Vector2):
	planned_grid_position = grid_position + movement
	print("Planned grid position: ", String(planned_grid_position))
	print()
	# CHECK IF THE PLAYER CAN MOVE
	if game.is_blocked(planned_grid_position):
		can_move = false # TODO At the moment we don't need this double check, but I'll keep it for now when I implement enemies
	if can_move:
		set_grid_position(planned_grid_position)	
	position = grid_position * TILE_SIZE
	can_move = true
	
func get_grid_position():
	return grid_position
	
func set_grid_position(new_position:Vector2):
	grid_position = new_position
	
