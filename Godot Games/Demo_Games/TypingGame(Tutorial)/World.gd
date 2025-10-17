extends Node2D

var active_text = null

var current_letter_index: int = -1

@onready var text = $Enemy

func find_new_active_text(typed_character: String):
	var prompt = text.get_prompt()
	print(typed_character," ",prompt," ",active_text)
	if prompt.substr(0, 1) == typed_character:
		active_text = text
		print(active_text)
	else:
		print("Wrong")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		if active_text == null:
			find_new_active_text(key_typed)
			
