extends Node2D
@onready var parallax_layer_scene = preload("res://Combat/ParallaxLayer.tscn") 

func _ready() -> void:
	load_background()

func load_background() -> void:
	var json_data = FileAccess.open("res://Data/map.json", FileAccess.READ)
	if json_data:
		var map_data = JSON.parse_string(json_data.get_as_text())
		if typeof(map_data) == TYPE_DICTIONARY:
			for key in map_data:
				# Tạo instance của 1 layer
				var parallax: Parallax2D = parallax_layer_scene.instantiate()
				var sprite: Sprite2D = parallax.get_child(0)		
				var path = map_data[key]["path"]
				if path:
					# Gán texture từ đường dẫn trong json
					var tex = load(path)
					if tex:
						sprite.texture = tex
						# Đặt tắt center offset
						sprite.centered = false
						# Đặt position về vector 0
						sprite.position = Vector2.ZERO
						# Full width screen sprite - phải gọi sau khi set texture
						fit_sprite_fullscreen(sprite)
						var scale_x = float(map_data[key].get('scroll_scale_x', 1))
						# Tuỳ chỉnh motion của parallax
						parallax.scroll_scale = Vector2(scale_x , 1) # layer này cuộn chậm hơn
						# THIẾT LẬP REPEAT ĐỂ LOOP
						# Cách 1: Sử dụng repeat_size
						var texture_size = sprite.texture.get_size()
						var scaled_width = texture_size.x * sprite.scale.x
						parallax.repeat_size = Vector2(scaled_width, 0)
					# Thêm parallax layer vào node cha (giả sử self là ParallaxBackground)
					add_child(parallax)
				else:
					print("path to map parallax layer invalid")
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
		print(scale_x, 1.0)
		sprite.scale = Vector2(scale_x, scale_y)
