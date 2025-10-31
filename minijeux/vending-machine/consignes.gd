extends RichTextLabel

@onready var consignes: RichTextLabel = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Trouve le code ![/wave][/color][/center]"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
