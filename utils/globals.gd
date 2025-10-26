extends Node

var money = 0.0
var stress = 0.0
var day = 0
var animations: Array[String] = [
	"perso_1",
	"perso_2",
	"perso_3",
	"perso_4",
    "perso_5"
]

var quetes_table = [
	QueteData.new("usb","res://minijeux/usb-key/usb_key.tscn","T_Speech_USB",true, 10),
	QueteData.new("windows","res://minijeux/restart-windows95/restart_windows95.tscn","T_Speech_Windows",true, 15),
	QueteData.new("cafe","res://minijeux/machine-a-cafe/machine-a-cafe.tscn","T_Speech_Coffee",false, 15),
	QueteData.new("car","res://minijeux/parking/parking.tscn","T_Speech_Car",false, 20),
	QueteData.new("vending","res://minijeux/vending-machine/control.tscn","T_Speech_Vending",false, 15)
]

# Liste des index des quêtes déjà lancées
var available_quests: Array[int] = [0,1,2,3,4]

func take_random_quest() -> Variant:
	if available_quests.is_empty():
		push_warning("Le pool est vide !")
		return null
	var index = randi() % available_quests.size()
	var value = available_quests[index]
	available_quests.remove_at(index)
	return value # retire et renvoie la valeur
	
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
	stress = 0.0
	day = 0
