class_name Player
extends CharacterBody2D

@export var speed := 200.0

func _physics_process(delta):
	
	var mouse_pos = get_global_mouse_position()
	var direction = Vector2.ZERO
	
	# Si le bouton gauche est maintenu
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		direction = (mouse_pos - global_position)
		
	else:
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
		# Normalisation pour que diagonales ne soient pas plus rapides
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * speed
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
	
