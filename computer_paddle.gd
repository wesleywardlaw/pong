extends CharacterBody2D

const SPEED = 300.0
const DEAD_ZONE = 5.0  # Tolerance in pixels

@onready var paddle_rect: ColorRect = $ColorRect
@onready var ball: Node2D = get_parent().get_node("Ball")
@onready var ball_rect: ColorRect = ball.get_node("ColorRect")

func _physics_process(delta: float) -> void:
	# Calculate center positions
	var paddle_center_y = position.y + paddle_rect.size.y / 2.0
	var ball_center_y = ball.position.y + ball_rect.size.y / 2.0

	var distance = ball_center_y - paddle_center_y

	# Decide movement
	if abs(distance) > DEAD_ZONE:
		velocity.y = sign(distance) * SPEED
	else:
		velocity.y = 0

	# Predict future position
	var future_y = position.y + velocity.y * delta
	var screen_height = get_viewport_rect().size.y
	var paddle_height = paddle_rect.size.y
	var wall_thickness = 17.0
	
	var min_y = wall_thickness
	var max_y = screen_height - wall_thickness - paddle_height

	# Clamp movement to stay within screen
	if future_y < min_y:
		velocity.y = 0
		position.y = min_y
	elif future_y > max_y:
		velocity.y = 0
		position.y = max_y

	move_and_slide()
