extends Area2D

@export var speed = 0

func _ready() -> void:
	hide()
	$CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("Move_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move_Down"):
		velocity.y += 1	
	
	if velocity.length() > 0:
		position += velocity.normalized()*speed*delta	
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	$AnimatedSprite2D.flip_h = false
	if velocity.x > 0 :
		$AnimatedSprite2D.animation = "walk_side"
	elif velocity.x < 0 :
		$AnimatedSprite2D.animation = "walk_side"
		$AnimatedSprite2D.flip_h = true
	elif velocity.y > 0 :
		$AnimatedSprite2D.animation = "walk_down"
	elif velocity.y < 0 :
		$AnimatedSprite2D.animation = "walk_up"	
	
	pass

func popPlayer(pPosition):
	#position = pPosition
	show()
	$CollisionShape2D.disabled = false
