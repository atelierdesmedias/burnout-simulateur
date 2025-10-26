extends Control

@onready var moneyBar: TextureProgressBar = $VBoxContainer/HBoxContainer/ProgressBarMoney
@onready var lifeBar: TextureProgressBar = $VBoxContainer/HBoxContainer2/ProgressBarBrain
@onready var gameover_map = preload("res://menus/game_over/gameover.tscn")
@onready var victory_map = preload("res://menus/victory/victory.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Globals.money += 0.005 * delta
	moneyBar.value = Globals.money
	lifeBar.value = Globals.stress
	
	if  Globals.money >= 1.0: 
		for child in get_tree().get_root().get_children():
			if child != get_tree().current_scene:
				child.queue_free()
		get_tree().change_scene_to_file("res://menus/victory/victory.tscn")
		pass
	elif  Globals.stress >= 1.0: 
		for child in get_tree().get_root().get_children():
			if child != get_tree().current_scene:
				child.queue_free()
		get_tree().change_scene_to_file("res://menus/game_over/gameover.tscn")
		pass	
	

func _input(event):
	if event is InputEventKey:
		# vérifie si la touche est pressée
		if event.pressed and event.keycode == Key.KEY_ESCAPE:
			get_tree().quit()  # quitte le jeu
