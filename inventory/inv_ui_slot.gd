extends Panel

var is_empty = true
var is_selected = false

signal equip_item

@export var single_button_press = false
 
@onready var on_click_button: Button = $On_click_button
var slot_to_equip = "Not_Equipable"
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display 
@onready var amount_text: Label = $CenterContainer/Panel/Label
@onready var menubutton: MenuButton = $MenuButton

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false        
	else :
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text  = str(slot.amount)
func _ready() -> void:
	
	menubutton.disabled = single_button_press
	on_click_button.disabled = !single_button_press
	
	on_click_button.visible = single_button_press
	
	var popup_menu = menubutton.get_popup()
	popup_menu.id_pressed.connect(on_popup_menu_pressed)
	
	
func on_popup_menu_pressed(id: int):
	var pressed_menu_item = menubutton.get_popup().get_item_text(id)
	if pressed_menu_item =="Drop":
		pass
	elif pressed_menu_item.contains("Equip") && slot_to_equip != "NotEquipable":
		equip_item.emit(slot_to_equip)
		
	

func add_item(item: InvItem):
	if item.slot_type != "Not_Equipable":
		var popup_menu: PopupMenu = menubutton.get_popup()
		var equip_slot_name_array = item.slot_type.to_lower().split("_")
		var equip_slot_name = " ".join(equip_slot_name_array)
		popup_menu.set_item_text(0,"Equip to " + equip_slot_name)
