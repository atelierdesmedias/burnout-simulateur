extends Node2D

var lastQuestTime
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastQuestTime = Time.get_ticks_msec()
	_popQuest()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var timeSinceLastQuest = Time.get_ticks_msec()-lastQuestTime	
	if timeSinceLastQuest > 5000:
		lastQuestTime = Time.get_ticks_msec()
		if randi_range(0,3) == 0:
			_popQuest()	
	pass

func _popQuest():
	var collegues = get_tree().get_nodes_in_group("collegues")  # toutes les instances
	
	if collegues.size() == 0:
		return

	var rand_index = randi() % collegues.size()
	var random_collegue = collegues[rand_index] as Collegue

	random_collegue._popQuest()	
	pass
	
func _on_mini_jeu_1_body_entered(body: Node2D) -> void:
	$"Mini-Jeu_1/Mini-jeu_1_Col".disabled = true
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = preload("res://minijeux/restart-windows95/restart_windows95.tscn")
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)		
	pass # Replace with function body.


func _on_mini_jeu_2_body_entered(body: Node2D) -> void:
	print("test")
	$"Mini-Jeu_2/Mini-jeu_2_Col".disabled = true
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = preload("res://minijeux/usb-key/usb_key.tscn")
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)
	pass # Replace with function body.
