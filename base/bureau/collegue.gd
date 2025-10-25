extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(randf()*10).timeout
	_popQuest()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _popQuest():
	$Exclamation.visible = true;
	
	pass
