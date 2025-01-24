extends Area2D

var player = null
var player_in_range = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_range = true
		body.interact_ui.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_in_range = false
		body.interact_ui.visible = false
