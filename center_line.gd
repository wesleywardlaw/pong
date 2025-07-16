extends Node2D

var dot_length = 10
var dot_gap = 10
var line_width = 4
var color = Color.WHITE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_height = get_viewport_rect().size.y
	var center_x = get_viewport_rect().size.x / 2
	
	var y = 10
	while y < viewport_height-10:
		var dot = Line2D.new()
		dot.width = line_width
		dot.default_color = color
		dot.points = [Vector2(center_x, y), Vector2(center_x, y + dot_length)]
		add_child(dot)
		y += dot_length + dot_gap


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
