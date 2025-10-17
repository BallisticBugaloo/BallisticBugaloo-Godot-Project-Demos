extends Control

@onready var text_edit: TextEdit = $TextEdit
#@onready var name_file: LineEdit = $NameFile

func _on_button_pressed() -> void:
	var text_save = text_edit.text
	#var file_name = name_file.text
	
	#CHeck if file name valid
	#if file_name == "":
		#print("Please enter a valid filename.")
		#return
	
	#Check if ".txt" extention is missing
	#if not file_name.ends_with(".txt"):
		#file_name += ".txt"
	
	#var file_path = "SaveFile/" + file_name
	#var file = FileAccess.open(file_path,FileAccess.WRITE)
	
	#if file:
		#file.store_string(text_save)
		#file.close()
		#print("Saved to", file_path)
	#else:
		#print("Failed")
