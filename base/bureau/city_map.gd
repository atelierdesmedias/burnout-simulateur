extends Node2D

@export var Start_Position : Vector2
var Screen_Size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Screen_Size = get_viewport_rect().size
	$Player_Office.popPlayer(Screen_Size/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
