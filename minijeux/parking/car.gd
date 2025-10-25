extends RigidBody2D

@export var acceleration = 800.0
@export var max_speed = 400.0
@export var steering = 3.0
@export var grip = 8.0  # Higher = less sliding
@export var pitch_speed=2.0


@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var input_forward=0.0

func _ready():
	linear_damp = 2.0
	angular_damp = 4.0  # Rotational friction
	player.stream = load("res://minijeux/parking/motor.ogg")

func _process(delta: float) -> void:
	if player.playing:
		var target_pitch=1.0
		if input_forward != 0:
			target_pitch = 2.0
		player.pitch_scale = lerp(player.pitch_scale, target_pitch, pitch_speed * delta)

		if player.get_playback_position() > 9:
			player.seek(6)
			
func _physics_process(delta):
	input_forward = 0.0
	if Input.is_action_pressed("ui_up"):
		if !player.playing:
			player.play()
			player.seek(1)
		if player.get_playback_position()>1.7:
			input_forward += 1
	if Input.is_action_pressed("ui_down"):
		input_forward -= 1

	var speed = linear_velocity.length()
	var moving_forward = linear_velocity.dot(Vector2.UP.rotated(rotation)) > 0

	# Only steer when moving forward
	if speed > 1 and moving_forward:
		var steer_strength = steering * (speed / max_speed)
		if Input.is_action_pressed("ui_left"):
			angular_velocity = -steer_strength
		elif Input.is_action_pressed("ui_right"):
			angular_velocity = steer_strength
	else:
		# No steering input; let angular_damp slow rotation naturally
		angular_velocity = 0

	# Accelerate in the direction the car is facing
	if input_forward != 0:
		var direction = Vector2.UP.rotated(rotation)
		apply_central_force(direction * acceleration * input_forward)

	# Simulate tire grip (reduce sideways sliding)
	var forward_dir = Vector2.UP.rotated(rotation)
	var side_dir = Vector2(-forward_dir.y, forward_dir.x)
	var side_speed = linear_velocity.dot(side_dir)
	var side_friction = -side_dir * side_speed * grip
	apply_central_force(side_friction)

	# Clamp speed
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
