extends Node

@onready var menu_container: Control = $MenuContainer
@onready var prompt_label:RichTextLabel = $typing_space/RichTextLabel
@onready var mistakes_label:Label = %Mistake_count
@onready var wpm_label:Label = %Words_per_min
@onready var prompt_text :String = prompt_label.text
@onready var camera:Camera2D = get_tree().get_first_node_in_group("camera")

var current_letter:int = 0
var wrong_inputs:int = 0
var time:float = 0.0
var msecs:int = 0
var secs:int = 0
var minutes:int = 0

func _ready() -> void:
	menu_container.visible = false
	%Volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	%Volume_slider.hide()
	stop_timer()
	randomize()
	prompt_text = StoredWords.get_prompt()
	#highlight_correct_input()

func _process(delta: float) -> void:
	timer(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if (event as InputEventKey).keycode == KEY_ESCAPE:
			if menu_container.visible == false:
				menu_container.show()
			else:
				menu_container.hide()
		
		if (event as InputEventKey).keycode == KEY_CTRL:
			reset_word_set()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():

		# Ignore all non-relevant inputs
		if event.unicode != 0:
			pass
		else:
			return
		
		var typed_char = char(event.unicode)
		
		if current_letter < prompt_text.length():
			var expected_char = prompt_text[current_letter]
			mistakes_label.text = 'Mistakes: ' + str(wrong_inputs)
			start_timer()
			if typed_char == expected_char:
				current_letter += 1
				highlight_correct_input()
				
				# Detects whether everything is typed
				if current_letter >= prompt_text.length():
					stats_display()
					stop_timer()
					print("word completed")
			else:
				#print("Wrong KEY! Expected '%s', got '%s'" %[expected_char, typed_char])
				highlight_wrong_input()
				camera.trigger_shake()
				wrong_inputs += 1
		else:
			pass

func _on_reset_bt_pressed() -> void:
	reset_word_set()

func _on_exit_bt_pressed() -> void:
	get_tree().quit()


func _on_custom_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Custome_test/create_custome_test.tscn")

func stop_timer() -> void:
	set_process(false)

func start_timer() -> void:
	set_process(true)

#Check and hilight correct inputs
func highlight_correct_input():
	var typed_part = "[color=003aff]" + prompt_text.substr(0, current_letter) + "[/color]"
	var remaining_part = prompt_text.substr(current_letter, prompt_text.length() - current_letter)
	prompt_label.bbcode_text = typed_part + remaining_part

func highlight_wrong_input():
	var typed_part = "[color=003aff]" + prompt_text.substr(0, current_letter) + "[/color]"
	var remaining_part = "[color=c00000]" + prompt_text.substr(current_letter, prompt_text.length() - current_letter) + "[/color]"
	prompt_label.bbcode_text = typed_part + remaining_part

#Reset and re-randomize the quote or setence to type.
func reset_word_set():
	get_tree().reload_current_scene()
	#wpm_label.text = 'Words Per Minute: ' + '0'
	#mistakes_label.text ='mistakes: ' + str(wrong_inputs)
	#prompt_text = StoredWords.get_prompt()
	#highlight_correct_input()

#Quits the whole game
func quit_game():
	get_tree().quit()

#Stores relevant data to display
func stats_display():
	var whole_num_time = int(time)
	var calculated_time = float(len(prompt_text)) / (5 * whole_num_time) * 60
	var words_per_minutes = int(calculated_time)
	mistakes_label.text ='Mistakes: ' + str(wrong_inputs)
	wpm_label.text = 'Words Per Minute: ' + str(words_per_minutes)

#Creates a timer
func timer(delta):
	time += delta
	msecs = fmod(time, 1) * 100
	secs = fmod(time,60)
	minutes = fmod(time,3600) / 60
	%minutes.text = "%01d:" % minutes
	%secs.text = "%02d." % secs
	%msecs.text = "%03d" % msecs

#Control Volume
func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

func _on_volume_button_mouse_entered() -> void:
	%Volume_slider.show()

func _on_volume_slider_mouse_exited() -> void:
	%Volume_slider.hide()

@onready var volumeButton: Button = $"Sound&Effects/Volume_Button"
var mute = false
var ifMuted = load("res://Assets/1. Free Hologram Interface Wenrexa/Icons/34.png")
var notMuted = load("res://Assets/1. Free Hologram Interface Wenrexa/Icons/35.png")
func _on_volume_button_pressed() -> void:
	if !mute:
		mute = true
		volumeButton.set_button_icon(ifMuted)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),true)
		print("Not Muted")
	elif mute:
		mute = false
		volumeButton.set_button_icon(notMuted)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)
		print("muted")
