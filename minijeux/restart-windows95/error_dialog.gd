extends Node2D

signal dialog_closed


func _on_ok_button_pressed() -> void:
	hide()
	emit_signal("dialog_closed")
