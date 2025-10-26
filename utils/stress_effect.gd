extends CanvasLayer

func  _process(delta: float) -> void:
	$ColorRect.material.set_shader_parameter("stress", 1. - Globals.life);
