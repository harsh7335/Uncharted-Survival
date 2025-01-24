extends Node2D

var player_in_exit_range = false
var player = null
var player_in_range = false
@onready var blue_tile = $blue_tile
@onready var red_tile = $red_tile
var blue_tile_erased = false
var red_tile_erased = false
var yellow_tile_erased = false
@onready var blue_button = $blue_button
@onready var red_button = $red_button
@onready var yellow_button = $yellow_button
@onready var yellow_tile = $yellow_tile

func _on_button_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_range = true
		body.interact_ui.visible = true
		



func _on_button_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_in_range = false
		body.interact_ui.visible = false
		if !player_in_range:
			print("out of range")

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("pickup") and !blue_tile_erased:
		blue_tile.queue_free()
		blue_tile_erased = true
		blue_button.queue_free()
		print("done")
	elif player_in_range and Input.is_action_just_pressed("pickup") and !red_tile_erased:
		red_tile.queue_free()
		red_tile_erased = true
		red_button.queue_free()
		print("done")
	elif  player_in_range and Input.is_action_just_pressed("pickup") and !yellow_tile_erased:
		yellow_tile.queue_free()
		yellow_tile_erased = true
		yellow_button.queue_free()
		print("done")
	if player_in_exit_range and Input.is_action_just_pressed("pickup"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")

func input():
	if Input.is_action_just_pressed("pickup"):
		print("interacted")


func _on_red_button_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_range = true
		body.interact_ui.visible = true



func _on_red_button_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_in_range = false
		body.interact_ui.visible = false


func _on_exit_house_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.interact_ui.visible = true
		player = body
		player_in_exit_range = true
		body.interact_ui.visible = true


func _on_exit_house_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_exit_range = false
		body.interact_ui.visible = false
		player = null
