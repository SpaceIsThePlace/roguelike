extends Entity

class_name Enemy

func _ready():
	grid_position = position/tile_size;
	color = Color(1.0, 0.0, 0.5, 1)
	modulate = color

func enemy_action():
	var x = randi()%3 - 1
	var y = randi()%3 - 1
	move(Vector2(x, y))
	print("Enemy position" + String(get_grid_position()))
