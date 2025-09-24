extends Camera2D

var move_speed := 200.0

func _process(delta):
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	
	# Di chuyển camera
	if input_vector != Vector2.ZERO:
		position += input_vector.normalized() * move_speed * delta
		
		# Cập nhật parallax background để tạo hiệu ứng infinite scroll
		#if parallax_background:
			#parallax_background.scroll_offset = position
