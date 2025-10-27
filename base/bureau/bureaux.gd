extends Area2D

@onready var modem: AudioStreamPlayer = $Modem
@onready var claviers = [$clavier, $clavier2, $clavier3, $clavier4]
var player_inside: bool = false
var saved_position: float = 0.0  # Position de lecture sauvegardée

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

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = true
		# Reprendre le son depuis la position actuelle si il était en pause
		if modem.playing == false:
			modem.seek(saved_position)
			modem.play(saved_position)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside = false
		# Mettre le son en pause mais garder la position
		if modem.playing:
			saved_position = modem.get_playback_position()  # sauvegarde la position
			modem.stop()
