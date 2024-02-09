extends Control

var rewards  = null: set = set_rewards
var items = null: set = set_items
var status = false: set = set_status
var id_item = "": set = set_id

signal update_bulletin_panel

func _ready():
	reset_reward_show()
	disabled_deliver_btn()

func set_id(val):
	id_item = val
	
func set_rewards(val):
	rewards = val
	if val != null:
		toggle_reward_show(val.coin, $RewardContainer/Coin)
		toggle_reward_show(val.gem, $RewardContainer/Gem)
		toggle_reward_show(val.exp, $RewardContainer/Exp)
	else:
		reset_reward_show()
	
func set_items(val):
	var items_panel = $ResourceContainer.get_children()
	var index = 0
	items = val
	for panel in items_panel:
		panel.set_item(null)
		if val != null:
			if index < val.size():
				panel.set_item(items[index])
		index += 1
	
	if check_all_qty_items():
		activated_deliver_btn()
	else:
		disabled_deliver_btn()

func set_status(val):
	status = val
	
func toggle_reward_show(val, reward_node):
	var children = reward_node.get_children()
	if val > 0:
		reward_node.visible = true
		children[1].text = str(val)
	else:
		reward_node.visible = false

func reset_reward_show():
	$RewardContainer/Coin.visible = false
	$RewardContainer/Gem.visible = false
	$RewardContainer/Exp.visible = false
	
func check_all_qty_items():
	var inv = InventoryItems.new()
	var status_check = true
	
	if items == null:
		return false 
		
	for i in items:
		if i.qty > inv.get_total_qty_by_name(i.name):
			status_check = false
			
	return status_check

func disabled_deliver_btn():
	$DeliverBtn.disabled = true
	$DeliverBtn.modulate = "797979"

func activated_deliver_btn():
	$DeliverBtn.disabled = false
	$DeliverBtn.modulate = "fff"
	
func _on_deliver_btn_pressed():
	var bullentin_data = BulletinDataManager.new()
	for item in items:
		bullentin_data.deliver_items(item)
	bullentin_data.item_delivered(self)
	update_bulletin_panel.emit()
	
