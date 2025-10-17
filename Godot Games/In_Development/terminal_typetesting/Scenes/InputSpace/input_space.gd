extends Control

@onready var prompt_text:String = $TextSpace.text

var current_letter:int = 0

func _ready() -> void:
	randomize()
	prompt_text = QuoteLibrary.get_prompt()
	highlight_correct_input() ##some how without this it won't display the right prompt


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		##Ignore all non_relevant inputs
		if event.unicode != 0:
			pass
		else:
			return
		
		var typed_char = char(event.unicode)
		
		if current_letter < prompt_text.length():
			var expected_char = prompt_text[current_letter]
			if typed_char == expected_char:
				current_letter += 1
				highlight_correct_input()
				
				##Detect whether everything is typed
				if current_letter >= prompt_text.length():
					print("Completed")
			else:
				print("WRONG KEY! Expected '%s', got '%s'" %[expected_char, typed_char])
		else:
			pass

##Check and highlight correct inputs
func highlight_correct_input():
	var correct_input = "[color=#e6e6e6]" + prompt_text.substr(0, current_letter) + "[/color]"
	var remaining_input = prompt_text.substr(current_letter, prompt_text.length() - current_letter)
	$TextSpace.bbcode_text = correct_input + remaining_input
	
