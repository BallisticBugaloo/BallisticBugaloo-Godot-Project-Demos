extends Node

var opt = option_array()

func _ready():
	option_array()

func option_array():
	var n = []
	for i in range(4):
		n.push_back(RandomWordDict.get_word(RandomWordDict.get_random_num()))
		var j = RandomWordDict.Array_of_Words.pop_at(RandomWordDict.get_random_num())
		print(n,j)
		#RandomWordDict.Array_of_Words.pop_at(RandomWordDict.get_random_num())
		
	var rand_index = randi() % n.size()
	var rand_word = n[rand_index]
	var dis_word = rand_word.substr(0, 1).to_upper() + rand_word.substr(1).to_lower()
	return [n,dis_word]
