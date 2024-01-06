extends Node2D

func _ready():
	$CoinLabel.text = str(CombatDetail.coin)
	$CoinSprites.play("idle")

func _process(_delta):
	$CoinLabel.text = str(CombatDetail.coin)
