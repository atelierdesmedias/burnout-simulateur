extends Control

@onready var buttons_numbers: Control = $Buttons_numbers
@onready var affichage: Label = $affichage # Correspond au code sur l'affichage de la machine
@onready var postit: Label = $postit # Correspond au code donné par le PNJ sur le post-it
@onready var drink: AudioStreamPlayer = $drink
@onready var erreur: AudioStreamPlayer = $erreur
@onready var effacer: AudioStreamPlayer = $Effacer
@onready var valider: AudioStreamPlayer = $Valider
@onready var consignes: RichTextLabel = $"../Timer/consignes"
@onready var timer: Timer = $"../Timer"

var code = randi_range(10000, 99999)
var code_tape : int :
	set(value):
		code_tape = value
		update_label()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in buttons_numbers.get_children() :
		var value = int(button.name.trim_prefix("Button"))
		button.pressed.connect(_on_button_value_pressed.bind(value))
	postit.text = str(code)
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Trouve le code ![/wave][/color][/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_value_pressed(value:int):
	if code_tape < 10000 :
		jouer_chiffre(value)
		code_tape = code_tape*10 + value
	else :
		erreur.play(0.5)


func _on_button_no_pressed() -> void:
	timer.start()
	consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Depeche toi ![/wave][/color][/center]"
	Globals.stress += 0.03
	effacer.play()
	code_tape = 0
	pass # Replace with function body.

func update_label():
	if code_tape == 0 :
		affichage.text = ""
	else :
		affichage.text = str(code_tape)

func _on_button_yes_pressed() -> void:
	valider.play()
	await valider.finished
	if code == code_tape:
		$".."._depopQuest()
		drink.play()
		get_parent().hide()
		get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
		await drink.finished
		queue_free()
	else :
		timer.start()
		consignes.text = "[center][color=#FFFFFF][wave amp=5 freq=50]Essaie encore ![/wave][/color][/center]"
		Globals.stress += 0.03
		erreur.play(0.5)
		code_tape = 0

func jouer_chiffre(value: int):
	var nom_noeud = "Chiffres%d" % value
	var son = get_node(nom_noeud)
	if son:
		son.play()


func _on_timer_timeout() -> void:
	consignes.text = ""
	pass # Replace with function body.
