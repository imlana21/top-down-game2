extends HBoxContainer

var slot_id: int = 0
var save_dir: String = ""
@export var file_name = "save"
var data_manager = null: set = set_data_manager
var status_popup = ""

signal load_game

func _ready():
	$Button.text = "Save"
	reset_slot()

func set_status(val):
	status_popup = val
	$Button.text = "  " + val.to_upper() + "  "
	var load_manager = SaveManager.new()
	data_manager = await load_manager.load_data(file_name + str(slot_id))
		
func set_data_manager(val):
	if !val or val == null:
		reset_slot()
	else:
		var month = str(val.created_at.month).pad_zeros(2)
		var day = str(val.created_at.day).pad_zeros(2)
		var year = str(val.created_at.year)
		data_manager = val
		set_slot("Slot " + str(slot_id), month + "/" + day + "/" + year)
		
	if status_popup == "save":
		$Button.disabled = false
	
func reset_slot():
	$Label/Name.text = "Empty"
	$Label/Date.text = "00/00/0000"
	$Button.disabled = true

func set_slot(label: String, date: String):
	$Label/Name.text = label
	$Label/Date.text = date
	$Button.disabled = false

func _on_button_pressed():
	if status_popup == "save":
		var save_load = SaveManager.new()
		save_load.save_data(file_name + str(slot_id))
	load_game.emit(data_manager)
