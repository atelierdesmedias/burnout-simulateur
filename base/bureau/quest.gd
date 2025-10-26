class_name Quest

extends Area2D

@export var questName := "cafe"
var questScene := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("quests")
	monitoring = false
	monitorable = false
	$Declenche_MiniJeu.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _ActivateJeu(pScene: String):
	questScene = pScene
	$Exclamation.visible = true
	monitoring = true
	monitorable = true
	$Declenche_MiniJeu.disabled = false
	pass
	
func _StartMinijeu():
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = load(questScene)
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)

func _on_body_entered(body: Node2D) -> void:
	if !(body is Player):
		return

	await get_tree().process_frame
	monitoring = false
	monitorable = false
	$Exclamation.visible = false
	if $Declenche_MiniJeu:
		$Declenche_MiniJeu.disabled = true		
	_StartMinijeu()
