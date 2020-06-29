extends Entity

class_name Player

signal player_action

func _ready():
	grid_position = position
	color = Color(0.0, 1.0, 0.5, 1)
	modulate = color

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("ui_up"):
				player_action(Vector2(0, -1))
			if event.is_action_pressed("ui_down"):
				player_action(Vector2(0, 1))
			if event.is_action_pressed("ui_left"):
				player_action(Vector2(-1, 0))
			if event.is_action_pressed("ui_right"):
				player_action(Vector2(1, 0))
			if event.is_action_pressed("ui_up_left"):
				player_action(Vector2(-1, -1))
			if event.is_action_pressed("ui_up_right"):
				player_action(Vector2(1, -1))
			if event.is_action_pressed("ui_down_left"):
				player_action(Vector2(-1, 1))
			if event.is_action_pressed("ui_down_right"):
				player_action(Vector2(1, 1))

func player_action(direction):
	move(Vector2(direction))
	print("\nPlayer position" + String(get_grid_position()))
	emit_signal("player_action")
