extends StaticBody2D

@export var item: InvItem
var player = null
var player_in_range = false

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_range = true
		body.interact_ui.visible = true





func playercollect():
	player.collect(item)
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_in_range = false
		body.interact_ui.visible = false

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("pickup"):
		print("collected")
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
