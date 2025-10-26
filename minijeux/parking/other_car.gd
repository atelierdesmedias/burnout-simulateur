extends RigidBody2D

func _ready() -> void:
	$AudioStreamPlayer.stream = load("res://minijeux/parking/crash.ogg")
	linear_damp = 2.0
	angular_damp = 4.0

func _on_body_entered(body: Node) -> void:
	$AudioStreamPlayer.play()
	Globals.stress += 0.01
