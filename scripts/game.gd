extends Node2D
@onready var house_detection_area = $house_detection_area
var player = null
var player_in_range = false


func _on_house_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.interact_ui.visible = true
		player = body
		player_in_range = true
		body.interact_ui.visible = true

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("pickup"):
		get_tree().change_scene_to_file("res://scenes/house_1.tscn")

func _on_house_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		body.interact_ui.visible = false
		player = null
