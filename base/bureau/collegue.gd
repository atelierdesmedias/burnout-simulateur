@tool
class_name Collegue

extends StaticBody2D

var hasQuest = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("collegues")	
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _popQuest():
	$Exclamation.visible = true
	$Exclamation.play("Green")
	remove_from_group("collegues")
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	pass # Replace with function body.
