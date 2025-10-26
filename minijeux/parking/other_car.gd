extends RigidBody2D

func _ready() -> void:
	$AudioStreamPlayer.stream = load("res://minijeux/parking/crash.ogg")
	linear_damp = 2.0
	angular_damp = 4.0

	var sprite_files = [
		"res://minijeux/parking/compact_blue.png",
		"res://minijeux/parking/compact_green.png",
		"res://minijeux/parking/compact_orange.png",
	]
	var random_index = randi() % sprite_files.size()
	var sprite_path = sprite_files[random_index]
	$Sprite2D.texture= load(sprite_path)


func _on_body_entered(body: Node) -> void:
	$AudioStreamPlayer.play()
	Globals.stress += 0.01
