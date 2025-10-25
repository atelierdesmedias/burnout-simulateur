extends Node2D

@onready var robinet=$Machine/Robinet
@onready var tasse=$Tasse

const min_x = -1100
const max_x = 300
const offset = 10
const max_velocity=1000

var velocity = 0.0
var direction_change_timer = 0.0
var direction_change_interval = 0.5 # seconds

func  _ready() -> void:
	_pick_new_velocity()
	$AudioStreamPlayer.stream = load("res://minijeux/machine-a-cafe/coffee.ogg")
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.stream_paused = true
	$AudioStreamPlayer.pitch_scale=0.5
	$AudioStreamPlayer.connect("finished", _coffee_full)
	
func _coffee_full():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()

func _process(delta):
	direction_change_timer += delta
	if direction_change_timer >= direction_change_interval:
		_pick_new_velocity()
		direction_change_timer = 0.0

	robinet.position.x += velocity * delta
	robinet.position.x = clamp(robinet.position.x, min_x, max_x )

	
func _pick_new_velocity():
	velocity = randf_range(-max_velocity, max_velocity) 

func _input(event):
	if event is InputEventMouseMotion:
		# Move tasse with mouse, clamp if needed
		var new_pos = get_global_mouse_position()
		# Optionally clamp new_pos.x and new_pos.y here
		tasse.global_position = new_pos

	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#print("pressed")


func _on_tasse_area_area_entered(area: Area2D) -> void:
	$AudioStreamPlayer.stream_paused = false


func _on_tasse_area_area_exited(area: Area2D) -> void:
	$AudioStreamPlayer.stream_paused = true
