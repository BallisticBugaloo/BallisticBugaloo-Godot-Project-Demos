extends Sprite2D

@onready var prompt = $EnemyText
@onready var prompt_text = prompt.text

func get_prompt() -> String:
	return prompt_text
