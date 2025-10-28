extends Node2D

@onready var claviers = [$clavier, $clavier2, $clavier3, $clavier4]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for clavier in claviers:
		if clavier.stream:
			var longueur = clavier.stream.get_length()  # Durée du son en secondes
			var position_aleatoire = randf() * longueur
			clavier.seek(position_aleatoire)  # Déplacer la tête de lecture
			clavier.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
