extends Area2D

@export var statusColor:Color = Color(0., 1., 0.)

func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		$ColorRect.color = check(body)
		return
	$ColorRect.color = Color(0., 1., 0.)
		

func check(body:RigidBody2D):
	var body_pos = body.global_position
	var local_pos = $CollisionShape2D.to_local(body_pos)
	if local_pos.length()< 10.:
		if body.linear_velocity.length() < 0.001:
			if abs(body.rotation)< 0.1:
				return Color(1., 0., 0.)
	return Color(1., 0.5, 0.)
		
