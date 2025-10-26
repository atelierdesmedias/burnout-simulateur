class_name QueteData
extends RefCounted

var name: String
var scene: String
var icon: String
var instant: bool
var stressTime: float

func _init(_name: String, _scene: String, _icon: String, _instant: bool, _stressTime: float):
	name = _name
	scene = _scene
	icon = _icon
	instant = _instant
	stressTime = _stressTime
