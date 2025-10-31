extends "res://minijeux/minijeu.gd"

@onready var robinet=$Machine/Robinet
@onready var tasse=$Tasse
@onready var timer: Timer = $Timer
@onready var consignes: RichTextLabel = $Timer/consignes
@onready var timer_2: Timer = $Timer/Timer2

const min_x = -140
const max_x = 0
const offset = 10
const max_velocity=500

var velocity = 0.0
var direction_change_timer = 0.0
var direction_change_interval = 0.5 # seconds

func  _ready() -> void:
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Remplis la tasse de cafe ![/wave][/color][/center]"
	$Machine/Robinet/cafe.play("default")
	_pick_new_velocity()
	$AudioStreamPlayer.stream = load("res://minijeux/machine-a-cafe/coffee.ogg")
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.stream_paused = true
	$AudioStreamPlayer.connect("finished", minijeu_finished)
	
func _process(delta):
	direction_change_timer += delta
	if direction_change_timer >= direction_change_interval:
		_pick_new_velocity()
		direction_change_timer = 0.0

	robinet.position.x += velocity * delta
	robinet.position.x = clamp(robinet.position.x, min_x, max_x )
	if($AudioStreamPlayer.stream_paused):
		Globals.stress += delta*0.015
		pass

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
	timer_2.stop()

func _on_tasse_area_area_exited(area: Area2D) -> void:
	$AudioStreamPlayer.stream_paused = true
	timer_2.start()
	consignes.text = ""


func _on_timer_timeout() -> void:
	consignes.text = ""
	pass # Replace with function body.


func _on_timer_2_timeout() -> void:
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]T'en fous partout ![/wave][/color][/center]"
	pass # Replace with function body.
