extends VBoxContainer

@onready var score_display = $score_disp
var score:String

func _process(delta: float) -> void:
	score = str(global.score)
	print(score)
	update_text()

func update_text():
	score_display.text = ("Score: " + score)
