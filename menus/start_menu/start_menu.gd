extends Control
@onready var starting_map = preload("res://base/bureau/city_map.tscn")

# Quit button : quit game
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
# Start button : launch game : city map
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(starting_map)
