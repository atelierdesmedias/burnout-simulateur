extends Area2D

@onready var embout: Area2D = $Embout
@onready var erreur: AudioStreamPlayer = $Erreur
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var connecting: AudioStreamPlayer = $"../../connecting"
@onready var disconnecting: AudioStreamPlayer = $"../../disconnecting"

var position_click
var is_dragging : bool
var drag_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if is_dragging:
			global_position = get_global_mouse_position() + drag_offset

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
			if event.pressed :
				position_click = get_global_mouse_position()
				is_dragging = true
				drag_offset = global_position - get_global_mouse_position()
			else :
				is_dragging = false
				# On checke si la position est proche de zero pour retourner la clef usb avec un click simple
				var position_delta = get_global_mouse_position().distance_to(position_click)
				if position_delta < 5.0 :
					sprite_2d.play()
				# On vérifie si l'embout est sur le port usb
				if embout.get_overlapping_areas():
					if randf()> 0.67:
						connecting.play()
						get_parent().get_parent().hide()
						get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
						await  connecting.finished
						queue_free()
					else :
						Globals.stress += 0.03
						connecting.play(0.4)
						await connecting.finished
						disconnecting.play(1)
				# On remet la position a zero
				position = Vector2.ZERO
