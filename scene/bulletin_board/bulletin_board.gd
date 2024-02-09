extends Control

func _ready():
	$RightBoard/Label.text = ""
	var panel_list = $LeftBoard/BoardPanelList.get_children()
	for panel in panel_list:
		panel.connect("panel_on_click", _on_panel_click_update_detail)
		panel.connect("throw_away", _refresh_panel)
	init_bulletin_panel()
	$RightBoard/PanelDetail.connect("update_bulletin_panel", init_bulletin_panel)

func init_bulletin_panel():
	var panel_list = $LeftBoard/BoardPanelList.get_children()
	var index = 0
	var bulletin_data = BulletinDataManager.new()
	bulletin_data = bulletin_data.get_all_items()
	for panel in panel_list:
		if index < bulletin_data.size():
			panel.set_status(bulletin_data[index].status)
			panel.set_rewards(bulletin_data[index].rewards)
			panel.set_item_list(bulletin_data[index].required_item)
			panel.set_id(bulletin_data[index].id)
			panel.set_tittle(bulletin_data[index].from)
		else:
			panel.set_status(false)
			panel.set_rewards(null)
			panel.set_item_list(null)
			panel.set_id(null)
			panel.set_tittle("")
		index += 1
		
func _refresh_panel(item_id):
	var bulletin_data = BulletinDataManager.new()
	bulletin_data.refresh_item(item_id)
	print("Form bulletin board ", item_id)
	init_bulletin_panel()

func _on_panel_click_update_detail(panel):
	$RightBoard/PanelDetail.set_rewards(panel.rewards)
	$RightBoard/PanelDetail.set_items(panel.item_list)
	$RightBoard/PanelDetail.set_id(panel.id_item)
	$RightBoard/PanelDetail.set_status(panel.status)
	$RightBoard/Label.text = panel.tittle
