extends Node2D
# Preload actor scene để tối ưu performance 
@onready var actor_scene = preload("res://Combat/Actor.tscn")
var actors: Array[Actor] = [] # Mảng lưu các actor đã load được
func _ready() -> void:
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
		# Tính toán vị trí dựa trên kích thước màn hình
		var screen_size = get_viewport_rect().size
		var actor_x = screen_size.x * 0.1 + index * (screen_size.x * 0.1)  # Bắt đầu từ 10% màn hình, cách nhau 8%
		var actor_y = screen_size.y * 0.8  # Đặt ở 60% chiều cao màn hình
		actor.position = Vector2(actor_x, actor_y)
		add_child(actor)	
		actors.append(actor) # Lưu actor vào mảng
		if actor.has_method('load_sprite'):
			actor.load_sprite(monster.frames)
		
	else:
		print("Actor scene not found")

func play_anim_for_all(anim: String) -> void:
	for actor in actors:
		if actor.has_method("play_animation"):
			
			actor.play_animation(anim)
