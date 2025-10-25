class_name Collegue

extends Area2D

var hasQuest = false

var quetes_table = [
	QueteData.new("usb","res://minijeux/usb-key/usb_key.tscn","Bubble",true,""),
	QueteData.new("windows","res://minijeux/restart-windows95/restart_windows95.tscn","Bubble",true,""),
	QueteData.new("cafe","res://minijeux/machine-a-cafe/machine-a-cafe.tscn","Green",false,"")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("collegues")	
	$Declenche_MiniJeu.disabled = true
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _popQuest():
	var lRandQuete = randi_range(0,2)
	var lQuest:QueteData = quetes_table[lRandQuete]
	
	$Exclamation.visible = true
	$Exclamation.play(lQuest.icon)
	remove_from_group("collegues")
	
	$Declenche_MiniJeu.disabled = false	
	pass

func _on_body_entered(body: Node2D) -> void:
	if !(body is Player):
		return	
	
	print("quête")
	$Declenche_MiniJeu.disabled = true	
	pass # Replace with function body.
