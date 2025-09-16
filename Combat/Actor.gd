class_name Actor extends Node2D

@onready var sprite = $AnimatedSprite2D

func load_sprite(sprite_path: String):
	var frame = load(sprite_path) as SpriteFrames
	if sprite && frame:
		sprite.sprite_frames = frame
		sprite.play("idle")
	
func play_animation(anim: String):
	await sprite.animation_finished
	sprite.play(anim)
	await sprite.animation_finished
	sprite.stop() 
