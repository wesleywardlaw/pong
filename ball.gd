extends CharacterBody2D

var speed = 500.0

signal ball_scored(side: String)


func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_ball_screen_exited)
	
	start_moving()
	
func _on_ball_screen_exited():
	var screen_size = get_viewport().get_visible_rect().size
	var ball_pos = global_position
	
	if ball_pos.x < -10:
		ball_scored.emit("left")
	elif ball_pos.x > screen_size.x + 10:
		ball_scored.emit("right")
	reset_ball_after_delay()

func reset_ball_after_delay():
	var screen_size = get_viewport().get_visible_rect().size
	print("hello")
	await get_tree().create_timer(1.5).timeout
	print("there")
	global_position = screen_size/2
	launch_ball()
	
func launch_ball():
	var direction = Vector2(randf_range(-1.0, 1.0), randf_range(-0.5,0.5)).normalized()
	
	if abs(direction.x) < 0.3:
		direction.x = 0.3 if direction.x > 0 else -0.3
		direction = direction.normalized()
	speed = 500.0
	velocity = direction * speed
	


func start_moving():
	var direction = Vector2(
		[-1, 1].pick_random(), 
		[-1, 1].pick_random()
	).normalized()
	velocity = direction * speed
	
var max_speed = 800
var speed_increase = 30
var debounce_timer = 0.0


func _physics_process(delta):
	# Move the ball and check for collisions
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		if collider and (collider.is_in_group("Paddle") or collider.is_in_group("Wall")):
			if collider.is_in_group("Paddle"):
				$PaddleHit.play()
			if collider.is_in_group("Wall"):
				$WallHit.play()
			var normal = collision.get_normal()
			
			# Bounce the velocity off the surface
			velocity = velocity.bounce(normal)
			
			# Increase speed with cap
			speed = min(speed + speed_increase, max_speed)
			
			# Ensure consistent speed
			velocity = velocity.normalized() * speed
			
			# Added to help prevent sticking
			position += normal * 15.0
			
			if velocity.length() < 0.1:
				velocity = normal*speed
			
			if abs(normal.dot(velocity.normalized())) < 0.2:
				velocity = (velocity + normal * speed * 0.5).normalized() * speed

	if velocity.length() < speed * 0.8:  # If speed drops below 80% of target
		velocity = velocity.normalized() * speed
