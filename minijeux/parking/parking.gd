extends "res://minijeux/minijeu.gd"

@onready var car= $Car

var t = 0.0

func _process(delta: float) -> void:
	t += delta
	if car.linear_velocity.length() < 0.001:
		if car.position.x < 1100:
			print("good " , t, car.rotation, car.linear_velocity)
			if abs(car.position.y- 190)< 10 and car.position.x > 150 and abs(car.rotation)< 0.1:
				print("parked")
				minijeu_finished()
