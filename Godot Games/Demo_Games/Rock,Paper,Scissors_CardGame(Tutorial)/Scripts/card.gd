class_name Card extends Node2D

@export var card_name:String = "Card Name"
@export var card_point: int = 0
@export var card_image: Node2D

@onready var name_lbl : Label = $CardName/NameLabel

func _ready():
	setCard_name(card_name)

func setCard_name(_name: String):
	card_name = _name
	name_lbl.set_text(_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
