extends KinematicBody2D

export var horizontal_step = 32.0
export var vertical_step = 32.0
var horizontal_movement = 0.0
var vertical_movement = 0.0

signal player_action

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			set_move (OS.get_scancode_string(event.scancode))

func set_move(direction):
	if (direction == "Up") || (direction ==  "Kp 8") || (direction ==  "W"):
		vertical_movement = -vertical_step
	if (direction == "Down") || (direction ==  "Kp 2") || (direction ==  "S"):
		vertical_movement = vertical_step
	if (direction == "Left") || (direction == "Kp 4") || (direction ==  "A"):
		horizontal_movement = -horizontal_step
	if (direction == "Right") || (direction ==  "Kp 6"  || (direction ==  "D")):
		horizontal_movement = horizontal_step
	if (direction ==  "Kp 7"):
		vertical_movement = -vertical_step
		horizontal_movement = -horizontal_step
	if (direction ==  "Kp 9"):
		vertical_movement = -vertical_step
		horizontal_movement = horizontal_step
	if (direction ==  "Kp 1"):
		vertical_movement = vertical_step
		horizontal_movement = -horizontal_step
	if (direction ==  "Kp 3"):
		vertical_movement = vertical_step
		horizontal_movement = horizontal_step
	if (direction ==  "Kp 5"):
		pass
	position += Vector2(horizontal_movement, vertical_movement)
	horizontal_movement = 0.0
	vertical_movement = 0.0
	emit_signal("player_action")
