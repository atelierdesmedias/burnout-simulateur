class_name MiniJeu

extends Node2D

var mCollegue: Collegue

func minijeu_finished():
	mCollegue._dePopQuest()
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()
