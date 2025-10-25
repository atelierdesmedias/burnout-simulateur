extends Node2D

func minijeu_finished():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()
