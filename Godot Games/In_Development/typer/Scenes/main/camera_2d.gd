extends Camera2D

@export var max_shake:float = 25.0
@export var shake_fade:float = 18.0

@onready var Penalty_effect: AudioStreamPlayer2D = %Penalty_effect

var _shake_str:float = 0.0

#Set _shake_str to max to trigger the shake
func trigger_shake() -> void:
	_shake_str = max_shake
	Penalty_effect.play()

#Shake screen when triggered
func _process(delta: float) -> void:
	if _shake_str > 0:
		_shake_str = lerp(_shake_str,0.0,shake_fade * delta)
		offset = Vector2(randf_range(-_shake_str, _shake_str), randf_range(-_shake_str, _shake_str))
