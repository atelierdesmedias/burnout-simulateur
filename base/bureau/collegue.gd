class_name Collegue

extends Area2D

var hasQuest = false

var quetes_table = [
	QueteData.new("usb","res://minijeux/usb-key/usb_key.tscn","T_Speech_USB",true,""),
	QueteData.new("windows","res://minijeux/restart-windows95/restart_windows95.tscn","T_Speech_Windows",true,""),
	QueteData.new("cafe","res://minijeux/machine-a-cafe/machine-a-cafe.tscn","T_Speech_Coffee",false,"")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("collegues")	
	monitoring = false
	monitorable = false
	$Declenche_MiniJeu.disabled = true
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _popQuest():
	var lRandQuete = randi_range(0,2)
	var lQuest:QueteData = quetes_table[lRandQuete]		
	
	$Exclamation.visible = true
	$Exclamation.play(lQuest.name)
	remove_from_group("collegues")	
	monitoring = true
	monitorable = true
	$Declenche_MiniJeu.disabled = false
	pass

func _on_body_entered(body: Node2D) -> void:
	if !(body is Player):
		return

	await get_tree().process_frame
	monitoring = false
	monitorable = false
	if $Declenche_MiniJeu:
		$Declenche_MiniJeu.disabled = true	
