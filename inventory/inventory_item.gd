extends Resource

class_name InvItem 

@export var name: String = ""
@export var texture: Texture2D 
@export_enum("Right_Hand","Left_hand","Potions","Not_Equiable")
var slot_type : String = "Not_Equipable"
@export var weapon: weaponitem
var player_in_range = false


func pickup():
	pass
