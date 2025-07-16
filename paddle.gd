extends CharacterBody2D

const SPEED = 300.0
const PADDLE_HEIGHT = 100.0  # Adjust based on your paddle's height

func _physics_process(delta):
	var direction := Input.get_axis("paddle_up", "paddle_down")
	var new_velocity := Vector2(0, direction * SPEED)
	var new_position = global_position + new_velocity * delta

	# Get the screen height
	var screen_height := get_viewport_rect().size.y
	
	# Clamp the Y position to stay within screen bounds
	var half_height := PADDLE_HEIGHT
	new_position.y = clamp(new_position.y, 17, 615)
	
	global_position = new_position
