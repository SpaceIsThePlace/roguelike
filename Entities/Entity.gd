extends Node2D

class_name Entity

export var grid_position = Vector2(0, 0)
export var color = (Color(0, 0, 0, 0))
var tile_size = 32

func move(movement):
	grid_position.x = clamp(grid_position.x + movement.x, 0, 1024/32) # TODO Remove this line, testing purposes only
	grid_position.y = clamp(grid_position.y + movement.y, 0, 640/32)
	position = grid_position * tile_size	
	
func get_grid_position():	
	return self.grid_position
