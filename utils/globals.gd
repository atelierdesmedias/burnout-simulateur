extends Node

var money = 0.0
var life = 1.0
var day = 0
var animations: Array[String] = [
	"perso_1",
	"perso_2",
	"perso_3",
	"perso_4",
    "perso_5"
]

# Tire une animation aléatoire et la retire de la liste
func take_random_animation() -> String:
	if animations.is_empty():
		push_warning("Plus d'animations disponibles !")
		return ""
	var index = randi_range(0, animations.size() - 1)
	var anim = animations[index]
	animations.remove_at(index)
	return anim
	
func reset():
	money = 0.0
	life = 1.0
	day = 0
