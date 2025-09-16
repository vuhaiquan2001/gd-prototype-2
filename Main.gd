extends Node2D

func _ready():
	var combat_scene = load("res://Combat/Combat.tscn") as PackedScene
	if combat_scene:
		var combat_instance = combat_scene.instantiate()
		add_child(combat_instance)
	else:
		print('combat_instance not found')
