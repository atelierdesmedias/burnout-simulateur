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
	if timeSinceLastQuest > 5000 || get_tree().get_nodes_in_group("collegues").size() == 4:
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
