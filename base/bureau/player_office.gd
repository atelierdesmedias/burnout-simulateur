class_name Player
extends CharacterBody2D

@export var speed := 200.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# Normalisation pour que diagonales ne soient pas plus rapides
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()  # gère les collisions automatiquement	
	
	# Animations
	if velocity.length() > 0:
		position += velocity.normalized()*speed*delta	
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	$AnimatedSprite2D.flip_h = false
	if velocity.x > 0 :
		$AnimatedSprite2D.animation = "walk_right"
	elif velocity.x < 0 :
		$AnimatedSprite2D.animation = "walk_left"
	elif velocity.y > 0 :
		$AnimatedSprite2D.animation = "walk_down"
	elif velocity.y < 0 :
		$AnimatedSprite2D.animation = "walk_up"	

func _process(delta: float) -> void:	
	pass
