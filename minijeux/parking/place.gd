extends Area2D


	
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is RigidBody2D:
			if check(body):
				$AnimatedSprite2D.hide()
				return
			$AnimatedSprite2D.frame = 1
			return
	$AnimatedSprite2D.frame = 0
		

func check(body:RigidBody2D):
	var body_pos = body.global_position
	var local_pos = $CollisionShape2D.to_local(body_pos)
	var norm_rot = wrapf(body.rotation, -PI, PI)
	var dist_to_0 = abs(norm_rot)
	var dist_to_pi = abs(abs(norm_rot) - PI)
	var min_dist = min(dist_to_0, dist_to_pi)

	if local_pos.length() < 10.:
		if body.linear_velocity.length() < 0.001:
			if min_dist < 0.1:
				return true
	return false
		
