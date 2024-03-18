class_name WarpWorld
extends Node2D

signal change_scene
signal start_combat
	
func _ready():
	Autoload.world = self
