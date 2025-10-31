extends Area2D

@onready var embout: Area2D = $Embout
@onready var erreur: AudioStreamPlayer = $Erreur
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var connecting: AudioStreamPlayer = $"../../connecting"
@onready var disconnecting: AudioStreamPlayer = $"../../disconnecting"
@onready var consignes: RichTextLabel = $"../../Timer/consignes"
@onready var timer: Timer = $"../../Timer"

var position_click
var is_dragging : bool
var drag_offset
var chance = 0
var busy : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Rentre la cle ![/wave][/color][/center]"
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if is_dragging and not busy:
			global_position = get_global_mouse_position() + drag_offset

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if busy:
		return
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
					chance = randf_range(0,chance+0.1)
					if sprite_2d.frame == 0:
						sprite_2d.play()
						timer.start()
						consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Tourne ![/wave][/color][/center]"
					else :
						sprite_2d.play("rotation",-1.0,true)
						timer.start()
						consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Et retourne, super nickel ![/wave][/color][/center]"
				# On vérifie si l'embout est sur le port usb
				if embout.get_overlapping_areas():
					busy = true
					chance = chance + 0.10
					if randf()< chance:
						$"../../.."._depopQuest()
						connecting.play()
						$"../../..".hide()
						get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
						await  connecting.finished
						queue_free()
					else :
						Globals.stress += 0.015
						connecting.play(0.3)
						await connecting.finished
						timer.start()
						consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Ca veut pas rentrer, reessaye ![/wave][/color][/center]"
						disconnecting.play(0.3)
						busy = false
				# On remet la position a zero
				position = Vector2.ZERO


func _on_timer_timeout() -> void:
	consignes.text = ""
	pass # Replace with function body.
