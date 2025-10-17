extends Node2D

#Goal: Create a Tool to Spawn a Card

@onready var card_scene: PackedScene = preload("res://Scenes/card.tscn")
@onready var spawnPoint = $CanvasLayer/DebugTool/Spawn

func _on_button_1_pressed():
	var create_card:Card = card_scene.instantiate()
	spawnPoint.add_child(create_card)
	create_card.setCard_name("Name one")

func _on_button_2_pressed():
	var create_card:Card = card_scene.instantiate()
	spawnPoint.add_child(create_card)
	create_card.setCard_name("Name Two")
	pass # Replace with function body.
