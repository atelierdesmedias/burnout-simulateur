extends Control
var game_paused  = false
@onready var pause_menu = $"."

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = true

func pause_game() :
	if game_paused :
		pause_menu.hide()
		get_tree().paused = false
	else :
		pause_menu.show()
		get_tree().paused = true

func _on_resume_button_pressed() -> void:
	game_paused = false

# Bouton quit : ferme le jeu
func _on_quit_button_pressed() -> void:
	get_tree().quit()
