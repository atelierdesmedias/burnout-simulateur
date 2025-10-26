extends Node2D

var timeSinceLastQuest = 0.0
var timeNextQuest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	timeNextQuest = randi_range(4,10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeSinceLastQuest += delta
	if timeSinceLastQuest > timeNextQuest || get_tree().get_nodes_in_group("collegues").size() == 4:
		timeNextQuest = randi_range(5,10)
		timeSinceLastQuest = 0.0
		if !Globals.available_quests.is_empty():
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
