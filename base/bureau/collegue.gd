class_name Collegue

extends Area2D

@export var giveQuest := true
var hasQuest = false
var mQuest:QueteData
var mQuestStartTime
var mCurrentQuest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	
	$AnimatedSprite2D.play(Globals.take_random_animation())
	if giveQuest : add_to_group("collegues")	
	monitoring = false
	monitorable = false
	$Declenche_MiniJeu.disabled = true
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if(hasQuest):
		if (Time.get_ticks_msec()-mQuestStartTime)*0.001 > 20:
			$Humeur.play("Red")
			$Humeur.visible = true
			Globals.stress += 0.02*delta
			pass
		elif (Time.get_ticks_msec()-mQuestStartTime)*0.001 > 10:
			$Humeur.play("Orange")
			$Humeur.visible = true
			Globals.stress += 0.01*delta
			pass
		else:			
			$Humeur.visible = false
			pass	
	pass

func _popQuest():
	mCurrentQuest = Globals.take_random_quest()
	mQuest = Globals.quetes_table[mCurrentQuest]	
	
	hasQuest = true
	mQuestStartTime = Time.get_ticks_msec()
	$Quete.visible = true
	$Quete.play(mQuest.name if mQuest.instant else "Green")
	remove_from_group("collegues")	
	monitoring = true
	monitorable = true
	$Declenche_MiniJeu.disabled = false
	pass

func _activateExternalQuest():
	var quests = get_tree().get_nodes_in_group("quests")	
	for pQuest:Quest in quests:
		if pQuest.questName == mQuest.name:
			pQuest._ActivateJeu(mQuest.scene, self)

func _dePopQuest():
	hasQuest = false
	$Quete.visible = false
	Globals.available_quests.append(mCurrentQuest)
	await get_tree().create_timer(5.0).timeout
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
		mQuestStartTime = Time.get_ticks_msec()
		_activateExternalQuest()
		$Quete.play(mQuest.name)
		pass
	
func _StartQuest():	
	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	var myNode = load(mQuest.scene)
	var myNode_instance = myNode.instantiate()
	myNode_instance.z_index = 11
	get_tree().get_root().add_child(myNode_instance)
	_dePopQuest()
