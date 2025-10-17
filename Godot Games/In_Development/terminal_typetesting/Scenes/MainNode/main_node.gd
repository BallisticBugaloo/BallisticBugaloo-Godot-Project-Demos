extends Node

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key_event := event as InputEventKey
		if key_event.is_command_or_control_pressed() and key_event.keycode == KEY_R:
			get_tree().reload_current_scene()
	
		##Show Menu
		if key_event.keycode == KEY_ESCAPE:
			if $MenuControl.visible != true:
				$MenuControl.show()
			else:
				$MenuControl.hide()
	ControlMenu(event)

func ControlMenu(event: InputEvent):
	if event is InputEventKey and event.is_pressed():
		var key_event := event as InputEventKey
		if key_event.is_command_or_control_pressed() and key_event.keycode == KEY_E:
			get_tree().quit()
