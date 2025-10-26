extends "res://minijeux/minijeu.gd"

@onready var car= $Car

var t = 0.0

const OtherCarScene = preload("res://minijeux/parking/other_car.tscn")
const PlaceScene = preload("res://minijeux/parking/place.tscn")
var places : Array[Node2D] = []

func _ready() -> void:
	$AudioStreamPlayer.stream = load("res://minijeux/parking/crash.ogg")
	car.connect("crash", _on_crash)
	for y in range(3):
		for x in range(21):
			if y == 2 and x < 4:
				continue
			if y == 1 and x > 18:
				continue
			var v = Vector2(64+50*x, 95+200*y)
			var place = PlaceScene.instantiate()
			place.position = v
			places.append(place)
			add_child(place)
			var to_car_vector = car.position - v;
			if randi() % 7 == 0 and to_car_vector.length() > 400:
				continue
			place.statusColor = Color(1., 0., 0.)
			var other_car = OtherCarScene.instantiate()
			other_car.position = v
			add_child(other_car)


func _process(delta: float) -> void:
	t += delta
	for place in places:
		if place.check(car) == Color(1., 0., 0.):
			await get_tree().create_timer(0.5).timeout
			minijeu_finished()

func _on_crash():
	$AudioStreamPlayer.play()
	Globals.stress += 0.01
