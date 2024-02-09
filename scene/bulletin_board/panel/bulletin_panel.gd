extends MarginContainer

@export var max_minutes = 0
@export var max_seconds = 5

var status: bool = false: set = set_status
var rewards = null: set = set_rewards
var item_list = null: set = set_item_list
var id_item = "": set = set_id
var tittle = "": set = set_tittle
var waiting_seconds = 5
var waiting_minutes = 0

signal panel_on_click
signal throw_away

func _ready():
	$Mark/Checklist.visible = false
	
# Setter
func set_tittle(val):
	tittle = val
	
func set_status(val):
	status = val
	if status:
		modulate = "eaeaea"
		$Mark/Checklist.visible = true

func set_item_list(val):
	item_list = val
	
func set_id(val):
	id_item = val
	
func set_rewards(val):
	rewards = val
	if val != null:
		toggle_reward_show(val.coin, $Container/Coin)
		toggle_reward_show(val.gem, $Container/Gem)
		toggle_reward_show(val.exp, $Container/Exp)
		$Mark/Delete.visible = true
	else:
		hide_rewards()

func toggle_reward_show(val, reward_node):
	var children = reward_node.get_children()
	if val > 0:
		reward_node.visible = true
		children[1].text = str(val)
	else:
		reward_node.visible = false

func hide_rewards():
	$Container/Coin.visible = false
	$Container/Gem.visible = false
	$Container/Exp.visible = false
	$Mark/Checklist.visible = false
	$Mark/Delete.visible = false

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !status:
		panel_on_click.emit(self)

func _on_delete_pressed():
	var bulletin_data = BulletinDataManager.new()
	if bulletin_data.delete_item(id_item):
		$Timer.start()
		$Label.text = str(waiting_minutes) + ":" + str(waiting_seconds)
		$Label.visible = true
		hide_rewards()

func _on_timer_timeout():
	waiting_seconds -= 1
	if waiting_seconds < 1:
		waiting_seconds = 60
		waiting_minutes -= 1
	$Label.text = str(waiting_minutes) + ":" + str(waiting_seconds)
	if waiting_minutes < 0:
		$Timer.stop()
		waiting_minutes = max_minutes
		waiting_seconds = max_seconds
		print("Form bulletin panel ", id_item)
		throw_away.emit(id_item)
		$Label.visible = false
