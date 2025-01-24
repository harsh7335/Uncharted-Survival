@tool
extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_texture = Texture
@export var item_effect = ""

var scene_path : String = "res://scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D
var player_in_range = false

func _ready() -> void:
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture

	if player_in_range and Input.is_action_just_pressed("pickup") :
		pickup_item()

func pickup_item():
	var item = {
		"quantity" : 1,
		"item_type" : item_type,
		"item_name" : item_name,
		"item_effect" :item_effect,
		"item_texture" : item_texture,
		"scene_path" : scene_path
	}
	if global.player_node:
		global.add_item(item)
		self.queue_free()




func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	body.interact_ui.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false 
	body.interact_ui.visible = false
	
