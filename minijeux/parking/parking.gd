extends "res://minijeux/minijeu.gd"

@onready var car= $Car

var t = 0.0

const OtherCarScene = preload("res://minijeux/parking/other_car.tscn")
const PlaceScene = preload("res://minijeux/parking/place.tscn")
var places : Array[Node2D] = []

func _ready() -> void:
	for x in range(22):
		for y in range(3):
			if y == 2 and x < 4:
				continue
			if y == 1 and x > 18:
				continue
			var v = Vector2(50+50*x, 100+200*y)
			var place = PlaceScene.instantiate()
			place.position = v
			places.append(place)
			add_child(place)
			var to_car_vector = car.position - v;
			if randi() % 10 == 0 and to_car_vector.length() > 400:
				continue
			place.busy = true
			var other_car = OtherCarScene.instantiate()
			other_car.position = v
			add_child(other_car)


func _process(delta: float) -> void:
	t += delta
	if car.linear_velocity.length() < 0.001:
		if car.position.x < 1100:
			print("good " , t, car.rotation, car.linear_velocity)
			if abs(car.position.y- 190)< 10 and car.position.x > 150 and abs(car.rotation)< 0.1:
				print("parked")
				minijeu_finished()
