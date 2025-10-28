extends "res://minijeux/minijeu.gd"

@onready var start_menu: Sprite2D = $Win95Panel/Ordinateur/Win95/StartMenu
@onready var win95_desktop: Sprite2D  = $Win95Panel/Ordinateur/Win95
@onready var win95_switching_off: Sprite2D  = $Win95Panel/Ordinateur/Restart
@onready var computer_off_screen: Sprite2D = $Win95Panel/Ordinateur/ComputerOff
@onready var computer_starting_animation: AnimatedSprite2D = $Win95Panel/Ordinateur/DosStarting
@onready var win95_starting: Sprite2D  = $Win95Panel/Ordinateur/Windows95Starting
@onready var startStream = preload("res://minijeux/restart-windows95/start.ogg")
@onready var quitStream = preload("res://minijeux/restart-windows95/quit.ogg")
@onready var errorStream = preload("res://minijeux/restart-windows95/error.ogg")


const ErrorDialogScene = preload("res://minijeux/restart-windows95/error_dialog.tscn")

var is_computer_on = true
var is_windows_started = true
var error_dialogs = []


func _ready():
	start_menu.hide()
	win95_desktop.show()
	win95_switching_off.hide()
	computer_off_screen.hide()
	computer_starting_animation.hide()
	win95_starting.hide()
	await get_tree().create_timer(0.5).timeout
	_add_error_dialog()


func _on_start_button_pressed() -> void:
	start_menu.visible = !start_menu.visible


func _on_power_off_button_pressed() -> void:	
	if is_computer_on:
		if error_dialogs.is_empty():
			is_windows_started = false
			start_menu.hide()
			$AudioStreamPlayer.stream = quitStream
			$AudioStreamPlayer.play()
			await get_tree().create_timer(0.5).timeout
			win95_desktop.hide()
			win95_switching_off.show()
			await get_tree().create_timer(1.0).timeout
			win95_switching_off.hide()
			computer_off_screen.show()
			is_computer_on = false
		else:
			_add_error_dialog()
	else:
		computer_off_screen.hide()
		is_computer_on = true
		computer_starting_animation.show()
		computer_starting_animation.play("default")
		await computer_starting_animation.animation_finished
		computer_starting_animation.hide()
		win95_starting.show()
		$AudioStreamPlayer.stream = startStream
		$AudioStreamPlayer.play()
		await get_tree().create_timer(2.0).timeout
		win95_starting.hide()
		win95_desktop.show()
		$AudioStreamPlayer.connect("finished", minijeu_finished)

func _on_win_95_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_windows_started:
			_add_error_dialog()

func _add_error_dialog() -> void:
	Globals.stress += 0.015
	var error_dialog = ErrorDialogScene.instantiate()
	error_dialog.position = Vector2(randi()%600, randi()%400)
	add_child(error_dialog)
	error_dialogs.append(error_dialog)
	error_dialog.connect(
		"dialog_closed", Callable(self, "_on_error_dialog_closed").bind(error_dialog)
	)
	$AudioStreamPlayer.stream = errorStream
	$AudioStreamPlayer.play()


func _on_error_dialog_closed(error_dialog):
	error_dialogs.erase(error_dialog)
	if error_dialogs.is_empty():
		print("All ErrorDialogs are closed!")
