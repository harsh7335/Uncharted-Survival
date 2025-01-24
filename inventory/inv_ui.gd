extends Control

@onready var inv:Inv = preload("res://inventory/playerinv.tres")
@onready var slots:Array = $NinePatchRect/GridContainer.get_children()
@export var size1 = 12
signal equip_item(idx: int,slot_to_equip)

var is_open = false 

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()
	for i in size1:
		
		slots[i].equip_item.connect(func(slot_to_equip: String): equip_item.emit(i,slot_to_equip))

func update_slots():
	for i in range(min(inv.slots.size(),slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory") :
		if is_open:
			close()
		else :
			open()

func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true
