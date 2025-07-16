extends Node2D

var player = 0
var computer = 0

@onready var ball = $Ball;
@onready var player_score = $UI/PlayerScore
@onready var computer_score = $UI/ComputerScore

func _ready():
	ball.ball_scored.connect(_on_ball_scored)

func _on_ball_scored(side: String) -> void:
	$Score.play()
	if side == "left":
		computer+=1
		computer_score.text = str(computer)
		print("computer scored")
	elif side == "right":
		player+=1
		player_score.text = str(player)
		print("player scored")
		
	if player >= 5:
		print("player wins")
	elif computer >=5:
		print("computer wins")
	
