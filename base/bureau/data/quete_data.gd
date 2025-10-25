class_name QueteData
extends RefCounted

var name: String
var scene: String
var icon: String
var instant: bool
var zone: String

func _init(_name: String, _scene: String, _icon: String, _instant: bool, _zone: String):
	name = _name
	scene = _scene
	icon = _icon
	instant = _instant
	zone = _zone
