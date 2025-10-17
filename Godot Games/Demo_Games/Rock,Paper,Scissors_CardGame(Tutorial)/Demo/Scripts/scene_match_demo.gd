extends Control

#Gets the nodes fromm the scene
@onready var matchDisplay = $DisplayText
@onready var optionOne = $MarginContainer/VBoxContainer/HBoxContainer/Match_one_Button
@onready var optionTwo = $MarginContainer/VBoxContainer/HBoxContainer/Match_one_Button2
@onready var optionThree = $MarginContainer/VBoxContainer/HBoxContainer2/Match_one_Button3
@onready var optionFour = $MarginContainer/VBoxContainer/HBoxContainer2/Match_one_Button4

var opt_arry = option_array()

#Gets a random word from RandomWordDict script
#sets value to matchDisplay and optionOne
func _ready():
	var endWord = opt_arry[0]
	var dis_word = opt_arry[1]
	matchDisplay.text = dis_word
	
	#optionTwo.text = option_array()
	#optionThree.text = option_array()
	#optionFour.text = option_array()
	#print(matchDisplay.text," ",optionOne.text)
	add_to_button(endWord)
	
	Option_one_button_pressed(optionOne)
	Option_two_button_2_pressed(optionTwo)
	Option_three_button_3_pressed(optionThree)
	Option_four_button_4_pressed(optionFour)

func add_to_button(n):
	var j = 0
	# Adds random word from array to a variable
	while j <= 4:
		print(n)
		if n.size() == 4:
			optionOne.text = n[-1]
			n.pop_back()
			print("one = ",optionOne.text)
			Option_one_button_pressed(optionOne)
		elif n.size() == 3:
			optionTwo.text = n[-1]
			n.pop_back()
			print("two = ",optionOne.text)
			Option_one_button_pressed(optionTwo)
		elif n.size() == 2:
			optionThree.text = n[-1]
			n.pop_back()
			print("three = ",optionOne.text)
			Option_one_button_pressed(optionThree)
		elif n.size() == 1:
			optionFour.text = n[-1]
			n.pop_back()
			print("four = ",optionOne.text)
			Option_one_button_pressed(optionFour)
		j += 1

func option_array():
	var n = []
	for i in range(4):
		n.push_back(RandomWordDict.get_word(RandomWordDict.get_random_num()))
		RandomWordDict.Array_of_Words.pop_at(RandomWordDict.get_random_num())
		#RandomWordDict.Array_of_Words.pop_at(RandomWordDict.get_random_num())
		
	var rand_index = randi() % n.size()
	var rand_word = n[rand_index]
	var dis_word = rand_word.substr(0, 1).to_upper() + rand_word.substr(1).to_lower()
	return [n,dis_word]

# Buttons to match the text to the matchDisplay text
func Option_one_button_pressed(option):
	if matchDisplay.text == option.text:
		print("Matching")
	else:
		print("Missmatch")
	#print(matchDisplay.text," ",optionOne.text)


func Option_two_button_2_pressed(option):
	if matchDisplay.text == option.text:
		print("Matching")
	else:
		print("Missmatch")


func Option_three_button_3_pressed(option):
	if matchDisplay.text == option.text:
		print("Matching")
	else:
		print("Missmatch")


func Option_four_button_4_pressed(option):
	if matchDisplay.text == option.text:
		print("Matching")
	else:
		print("Missmatch")
