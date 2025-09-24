class_name Actor extends Node2D

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	scale = Vector2(1.5, 1.5)

func load_sprite(sprite_path: String):
	var frame = load(sprite_path) as SpriteFrames
	if sprite && frame:
		sprite.sprite_frames = frame
		sprite.play("idle")
	
func play_animation(anim: String):
	print('Play anim all: ', anim)
	sprite.play(anim)
	await sprite.animation_finished
	sprite.stop() 
