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

	# Clamp movement to stay within screen
	if future_y < 0:
		velocity.y = 0
		position.y = 0
	elif future_y + paddle_height > screen_height:
		velocity.y = 0
		position.y = screen_height - paddle_height

	move_and_slide()
