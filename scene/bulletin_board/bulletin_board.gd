extends Control

func _ready():
	var panel_list = $LeftBoard/BoardPanelList.get_children()
	for panel in panel_list:
		panel.connect("panel_on_click", _on_panel_click_update_detail)
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
		else:
			panel.set_status(false)
			panel.set_rewards(null)
			panel.set_item_list(null)
			panel.set_id(null)
		index += 1

func _on_panel_click_update_detail(panel):
	$RightBoard/PanelDetail.set_rewards(panel.rewards)
	$RightBoard/PanelDetail.set_items(panel.item_list)
	$RightBoard/PanelDetail.set_id(panel.id_item)
	$RightBoard/PanelDetail.set_status(panel.status)
