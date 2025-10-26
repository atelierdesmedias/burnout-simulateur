extends Area2D

@export var busy = false

func _process(delta: float) -> void:
	if busy:
		$ColorRect.color = Color(1., 0, 0)
	else:
		$ColorRect.color = Color(0., 1, 0)
