extends Node2D
# Goal:
# - Get four words from the array
# - Add random word from array to a variable
# - remove words added to varaiibles from array
var Array_of_Words = [
	"hi",
	"bye",
	"tons",
	"late",
	"dumb",
	"numb"
	]

func _ready():
	# Gets four random words from array and adds them to a different array
	var n = []
	var j = 0
	var one
	var two 
	var three
	var four
	
	for i in range(4):
		n.push_back(get_word())
		print(n)
	
	# Adds random word from array to a variable
	while j <= 4:
		if n.size() == 4:
			one = n[-1]
			n.pop_back()
			print("one = ",one)
		elif n.size() == 3:
			two = n[-1]
			n.pop_back()
			print("two = ",two)
		elif n.size() == 2:
			three = n[-1]
			n.pop_back()
			print("three = ",three)
		elif n.size() == 1:
			four = n[-1]
			n.pop_back()
			print("four = ",four)
		j += 1

func get_word() -> String:
	var word_index = randi() % Array_of_Words.size()
	
	var rand_word = Array_of_Words[word_index]
	
	var chosen_word = rand_word.substr(0, 1).to_upper() + rand_word.substr(1).to_lower()
	
	Array_of_Words.pop_at(word_index)
	print(Array_of_Words)
	
	return chosen_word
