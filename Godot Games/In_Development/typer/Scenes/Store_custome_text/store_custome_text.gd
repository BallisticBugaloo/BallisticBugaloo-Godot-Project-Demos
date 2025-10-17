extends Control

@onready var file_naming: Control = $File_Naming
@onready var name_File: LineEdit = $FileName/NameFIle
var named_file:String

func _ready():
	pass
	#file_naming.hide()
	#name_File.text() = "Default"
#
#func _unhandled_input(event: InputEvent) -> void:
	## Add new test
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():
		#if (event as InputEventKey).keycode == KEY_ENTER:
			#file_naming.hide()
			#print(named_file)
#
#func _on_add_bt_pressed() -> void:
	##show only when adding new tests
	#if file_naming.visible == false:
		#file_naming.show()
