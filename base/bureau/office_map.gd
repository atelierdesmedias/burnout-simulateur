extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mini_jeu_1_body_entered(body: Node2D) -> void:
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = preload("res://minijeux/restart-windows95/restart_windows95.tscn")
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)	
	pass # Replace with function body.


func _on_mini_jeu_2_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	var myNode = preload("res://minijeux/usb-key/usb_key.tscn")
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)
	pass # Replace with function body.
