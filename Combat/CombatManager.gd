extends Node2D
# Preload actor scene để tối ưu performance 
@onready var party_scene = preload("res://Combat/Party.tscn")
@onready var backgound_scene = preload("res://Combat/Background.tscn")
@onready var camera_scene = preload("res://Combat/Camera.tscn")

func _ready() -> void:
	#add background
	var background = backgound_scene.instantiate()
	var party = party_scene.instantiate()
	var camera = camera_scene.instantiate()
	add_child(background)
	#add_child(party)
	add_child(camera)
	party.name = "Party"
	camera.add_child(party) # Party là con của Camera
	
