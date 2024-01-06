extends Node2D

func _ready():
	$GemLabel.text = str(CombatDetail.gem)
	$GemSprites.play("idle")

func _process(_delta):
	$GemLabel.text = str(CombatDetail.gem)	
