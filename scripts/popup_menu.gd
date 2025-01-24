extends MarginContainer

@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var help_menu_screen: MarginContainer
@export var settings_menu_screen: MarginContainer
@export var quit_menu_screen: MarginContainer
func toggle_visiblity(object):
	object.visible = !object.visible


func _on_toggle_menu_button_pressed() -> void:
	toggle_visiblity(menu_screen)
	toggle_visiblity(open_menu_screen)


func _on_toggle_help_button_pressed() -> void:
	toggle_visiblity(help_menu_screen)
	toggle_visiblity(menu_screen)


func _on_toggle_settings_button_pressed() -> void:
	toggle_visiblity(settings_menu_screen)
	toggle_visiblity(menu_screen)


func _on_toggle_quit_button_pressed() -> void:
	toggle_visiblity(quit_menu_screen)
	toggle_visiblity(menu_screen)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_h_scroll_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
