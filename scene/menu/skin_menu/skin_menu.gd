extends Control

func _ready():
	$NormalSkin/Normal.play("default")
	$RedSkin/Red.play("default")
	check_active_skin()

func _process(_delta):
	check_active_skin()
	
func _on_normal_skin_pressed():
	select_skin("normal")

func _on_red_skin_pressed():
	select_skin("red")
	
func select_skin(skin):
	Autoload.player_skin = skin
	Autoload.toggle_pause()
	if !Autoload.is_paused:
		$".".hide()

func check_active_skin():
	if Autoload.player_skin == "normal":
		$NormalSkin/Status.text = "equiped"
		$NormalSkin.modulate = "cecece"
		$RedSkin/Status.text = ""
		$RedSkin.modulate = "fff"
	else:
		$NormalSkin/Status.text = ""
		$NormalSkin.modulate = "fff"
		$RedSkin/Status.text = "equiped"
		$RedSkin.modulate = "cecece"
