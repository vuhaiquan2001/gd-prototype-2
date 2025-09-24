extends Node2D
# Preload actor scene để tối ưu performance 
@onready var actor_scene = preload("res://Combat/Actor.tscn") 
@onready var parallax_layer_scene = preload("res://Combat/ParallaxLayer.tscn") 

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
	var json_data = FileAccess.open("res://Data/map.json", FileAccess.READ)
	if json_data:
		var map_data = JSON.parse_string(json_data.get_as_text())
		if typeof(map_data) == TYPE_DICTIONARY:
			for key in map_data:
				# Tạo instance của 1 layer
				var parallax: Parallax2D = parallax_layer_scene.instantiate()
				var sprite: Sprite2D = parallax.get_child(0)
				print(map_data[key])
				# Gán texture từ đường dẫn trong json
				var tex = load(map_data[key])
				if tex:
					sprite.texture = tex
					# Đặt tắt center offset
					sprite.centered = false
					# Đặt position về vector 0
					sprite.position = Vector2.ZERO
					# Full width screen sprite - phải gọi sau khi set texture
					fit_sprite_fullscreen(sprite)
					# Tuỳ chỉnh motion của parallax
					parallax.scroll_scale = Vector2(0.5, 1) # layer này cuộn chậm hơn
				# Thêm parallax layer vào node cha (giả sử self là ParallaxBackground)
				add_child(parallax)
		else:
			print("map.json format is invalid")
	else:
		print("Background scene not found")
		
func fit_sprite_fullscreen(sprite: Sprite2D) -> void:
	if sprite.texture:
		var tex_size = sprite.texture.get_size()
		var screen_size = get_viewport_rect().size
		var scale_x = screen_size.x / tex_size.x
		var scale_y = screen_size.y / tex_size.y
		print(scale_x, scale_y)
		sprite.scale = Vector2(scale_x, scale_y)
