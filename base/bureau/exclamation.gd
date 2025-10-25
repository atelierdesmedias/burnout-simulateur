extends AnimatedSprite2D  # ou Node2D si c’est une icône

@export var amplitude: float = 3.0  # déplacement en pixels
@export var speed: float = 1.0       # vitesse

func _ready():
	var tween = create_tween()
	tween.set_loops()  # boucle infinie
	tween.tween_property(self, "position:y", position.y - amplitude, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + amplitude, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
