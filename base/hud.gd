extends Control

@onready var bar: TextureProgressBar = $VBoxContainer/HBoxContainer/ProgressBarMoney

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bar.value = Globals.money;
	
	pass

func _input(event):
	if event is InputEventKey:
		# vérifie si la touche est pressée
		if event.pressed and event.keycode == Key.KEY_ESCAPE:
			get_tree().quit()  # quitte le jeu
