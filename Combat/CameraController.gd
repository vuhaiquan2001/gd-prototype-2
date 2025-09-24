extends Camera2D

var move_speed := 200.0
var was_moving = false
func _process(delta):
	#move(delta)
	auto_move(delta)

func move(delta) ->void:
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	
	# Di chuyển camera
	var party = get_node_or_null("Party")
	
	if input_vector != Vector2.ZERO:
		position += input_vector.normalized() * move_speed * delta
		if party and party.has_method("play_anim_for_all"):
			party.play_anim_for_all("run")
		was_moving = true
	else:
		if was_moving:
			if party and party.has_method("play_anim_for_all"):
				party.play_anim_for_all("idle")
			was_moving = false

func auto_move(delta) -> void:
	position.x += move_speed * delta
	
	var party = get_node_or_null("Party")
	if party and party.has_method("play_anim_for_all"):
			party.play_anim_for_all("run")
