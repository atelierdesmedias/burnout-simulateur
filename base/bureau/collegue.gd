class_name Collegue

extends Area2D

var hasQuest = false
var mQuest:QueteData

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
	mQuest = quetes_table[lRandQuete]		
	
	$Exclamation.visible = true
	$Exclamation.play(mQuest.name if mQuest.instant else "Green")
	remove_from_group("collegues")	
	monitoring = true
	monitorable = true
	$Declenche_MiniJeu.disabled = false
	pass
	
func _dePopQuest():
	hasQuest = false
	$Exclamation.visible = false
	add_to_group("collegues")	
	
func _on_body_entered(body: Node2D) -> void:
	if !(body is Player):
		return

	await get_tree().process_frame
	monitoring = false
	monitorable = false
	if $Declenche_MiniJeu:
		$Declenche_MiniJeu.disabled = true	
	
	if(mQuest.instant):
		_StartQuest()
	else:
		$Exclamation.play(mQuest.name)
		pass
	
func _StartQuest():	
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = load(mQuest.scene)
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)
	_dePopQuest()
