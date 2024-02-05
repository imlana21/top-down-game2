extends MarginContainer

var status: bool = false: set = set_status
var rewards = null: set = set_rewards
var item_list = null: set = set_item_list
var id_item: set = set_id

signal panel_on_click

# Setter
func set_status(val):
	status = val
	if status:
		modulate = "eaeaea"
		$Checklist.visible = true

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
	else:
		reset_reward_show()

func toggle_reward_show(val, reward_node):
	var children = reward_node.get_children()
	if val > 0:
		reward_node.visible = true
		children[1].text = str(val)
	else:
		reward_node.visible = false

func reset_reward_show():
	$Container/Coin.visible = false
	$Container/Gem.visible = false
	$Container/Exp.visible = false
	$Checklist.visible = false

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !status:
		panel_on_click.emit(self)
	
