extends Node2D
# Preload actor scene để tối ưu performance 
@onready var actor_scene = preload("res://Combat/Actor.tscn") 
@onready var background = preload("res://Combat/Background.tscn") 

func _ready() -> void:
	load_background()
	var json_data = FileAccess.open("res://Data/monster.json", FileAccess.READ)
	if json_data:
		var data = JSON.parse_string(json_data.get_as_text())
		if data != null:
			var monsters = data
			for i in monsters.size():
				# Gọi hàm spawn_actor cho mỗi monster trong danh sách
				spawn_actor(monsters[i], i)

# Spawn một actor đơn lẻ
func spawn_actor(monster, index) -> void:
	print("Actor spawn ", monster.name)
	if actor_scene:
		var actor = actor_scene.instantiate() as Actor
		actor.position = Vector2( 100 + index * 80  ,  300)
		add_child(actor)	
		if actor.has_method('load_sprite'):
			actor.load_sprite(monster.frames)
		
	else:
		print("Actor scene not found")

func load_background() -> void:
	if background:
		print("Load")
		var bg = background.instantiate()
		add_child(bg)
	else:
		print("Background scene not found")
