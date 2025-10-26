extends RigidBody2D

@export var acceleration = 800.0
@export var max_speed = 400.0
@export var steering = 3.0
@export var grip = 8.0  # Higher = less sliding
@export var pitch_speed=2.0


@onready var motorPlayer: AudioStreamPlayer = $MotorPlayer
@onready var handBrakePlayer: AudioStreamPlayer = $HandBrakePlayer

var input_forward=0.0

func _ready():
	linear_damp = 2.0
	angular_damp = 4.0
	motorPlayer.stream = load("res://minijeux/parking/motor.ogg")
	handBrakePlayer.stream = load("res://minijeux/parking/handbrake.ogg")

func _process(delta: float) -> void:
	if motorPlayer.playing:
		var target_pitch=1.0
		if input_forward != 0:
			target_pitch = 2.0
		motorPlayer.pitch_scale = lerp(motorPlayer.pitch_scale, target_pitch, pitch_speed * delta)

		if motorPlayer.get_playback_position() > 9:
			motorPlayer.seek(6)
	if Input.is_action_just_pressed("brake"):
		if linear_damp < 10.0:
			linear_damp = 20.0
			handBrakePlayer.play()
		else:
			linear_damp = 2.0
			
func _physics_process(delta):
	input_forward = 0.0
	if Input.is_action_pressed("move_up"):
		if !motorPlayer.playing:
			motorPlayer.play()
			motorPlayer.seek(1)
		if motorPlayer.get_playback_position()>1.7:
			input_forward += 1
	if Input.is_action_pressed("move_down"):
		input_forward -= 1

	var speed = linear_velocity.length()
	var moving_backward = linear_velocity.dot(Vector2.UP.rotated(rotation)) < 0

	if speed > 1:
		var steer_strength = steering * (speed / max_speed)
		if moving_backward:
			steer_strength = -steer_strength
		if Input.is_action_pressed("move_left"):
			angular_velocity = -steer_strength
		elif Input.is_action_pressed("move_right"):
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
