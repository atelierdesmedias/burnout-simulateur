extends "res://minijeux/minijeu.gd"

@onready var car= $Car

const OtherCarScene = preload("res://minijeux/parking/other_car.tscn")
const PlaceScene = preload("res://minijeux/parking/place.tscn")
var places : Array[Node2D] = []

func _ready() -> void:
	$AudioStreamPlayer.stream = load("res://minijeux/parking/crash.ogg")
	car.connect("crash", _on_crash)
	for y in range(4):
		for x in range(21):
			# remove
			#if y != 3 or x != 6:
				#continue
			#print(x,"x", y)
			# after
			if y >= 3 and x < 3:
				continue
			if (y == 1 or y == 2) and x > 18:
				continue
			var v = Vector2(64+50*x, 95+130*y)
			if y == 1:
				v.x += 1
			if y == 2:
				v.x += 2
			if y == 3:
				v.x += 10
				v.y += 20
			if y % 2 == 1:
				v.y  += 45
			var place = PlaceScene.instantiate()
			place.position = v
			if y % 2 == 0:
				place.rotation = PI
			places.append(place)
			add_child(place)
			var to_car_vector = car.position - v;
			if randi() % 7 == 0 and to_car_vector.length() > 400:
				continue
			var other_car = OtherCarScene.instantiate()
			other_car.position = v
			add_child(other_car)


func _process(delta: float) -> void:
	#print(car.rotation )
	for place in places:
		if place.check(car):
			await get_tree().create_timer(0.5).timeout
			minijeu_finished()

func _on_crash():
	$AudioStreamPlayer.play()
	Globals.stress += 0.01
