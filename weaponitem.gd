extends Resource

class_name weaponitem

@export var in_hand_texture: Texture
@export var side_hand_texture: Texture
@export var collision_shape: RectangleShape2D
@export_enum ("meele","ranged","magic") var attack_type:String


@export_group("attachment_pos")
@export var left_attachment_pos: Vector2
@export var right_attachment_pos: Vector2
@export var front_attachment_pos: Vector2
@export var back_attachment_pos: Vector2
@export_group("")

@export_group("rotation")
@export var left_rotation: int
@export var right_rotation: int
@export var front_rotation: int
@export var back_rotation: int
@export_group("")

@export_group("z_index")
@export var left_z_index: int
@export var right_z_index: int
@export var front_z_index: int
@export var back_z_index: int
@export_group("")

func get_direction(direction: String):
	match direction:
		"left":
			return {
				"attachment_pos": left_attachment_pos,
				"rotation": left_rotation,
				"z_index": left_z_index
			}
		"right":
			return{
				"attachment_pos": right_attachment_pos,
				"rotation": right_rotation,
				"z_index": right_z_index
			}
		"front":
			return{
				"attachment_pos": front_attachment_pos,
				"rotation": front_rotation,
				"z_index": front_z_index
				
			}
		"back":
			return{
				"attachment_pos": back_attachment_pos,
				"rotation": back_rotation,
				"z_index": back_z_index
			}
