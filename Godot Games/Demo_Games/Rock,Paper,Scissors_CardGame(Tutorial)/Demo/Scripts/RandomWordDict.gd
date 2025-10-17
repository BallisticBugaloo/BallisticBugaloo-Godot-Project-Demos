extends Node

# Words to display to DisplayText
var Array_of_Words = [
'あ', 'い', 'う', 'え', 'お',
'か', 'き', 'く', 'け', 'こ',
'さ', 'し', 'す', 'せ', 'そ',
'た', 'ち', 'つ', 'て', 'と',
'な', 'に', 'ぬ', 'ね', 'の',
'は', 'ひ', 'ふ', 'へ', 'ほ',
'ま', 'み', 'む', 'め', 'も',
'や', 'ゆ', 'よ',
'ら', 'り', 'る', 'れ', 'ろ',
'わ', 'をW 	', 'ん']

func get_random_num() -> int:
	randomize()
	var randNum = randi() % Array_of_Words.size()
	#var randNum = randi_range(1,Array_of_Words.size())
	return randNum

func get_word(randNum) -> String:
	var rand_word = Array_of_Words[randNum]
	var chosen_word = rand_word.substr(0, 1).to_upper() + rand_word.substr(1).to_lower()
	Array_of_Words.pop_at(randNum)
	return chosen_word
