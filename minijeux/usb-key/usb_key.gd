extends Area2D

@onready var embout: Area2D = $Embout
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var erreur: AudioStreamPlayer = $Erreur

var is_dragging : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position()

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
			if event.pressed :
				is_dragging = true
			else :
				is_dragging = false
				if embout.get_overlapping_areas():
					if randf()> 0.67:
						return
					else :
						erreur.play(0.5)
				#checker si la position est proche de zero pour retourner la clef usb avec un click simple
				#remettre la position a zero
				position = Vector2.ZERO
