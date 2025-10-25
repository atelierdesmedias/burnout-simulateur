extends Node2D

@onready var start_menu: Sprite2D = $Ordinateur/Win95Panel/StartMenu


func _ready():
	start_menu.hide()

func _on_start_button_pressed() -> void:
	print("start")
	start_menu.visible = !start_menu.visible

func _on_power_off_button_pressed() -> void:
	print("Clicked on power off")
	start_menu.hide()


func _on_win_95_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("panel")
