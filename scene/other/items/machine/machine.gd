extends CharacterBody2D

var mouse_in_area: bool = false
var machine_number: int = 0
var waiting_time: Dictionary = {
	"slot1": 0,
	"slot2": 0
}
var queue_item: Dictionary = {
	"slot1": null,
	"slot2": null
}
var result_item: Dictionary = {
	"slot1": null,
	"slot2": null
}
var crafting_result: Dictionary = {
	"wood": {
			"name": "charcoal",
			"inventory": "player",
			"qty": 1,
			"stack_size": 12,
			"wait_time": 5
		},
		"wheat": {
			"name": "bread",
			"inventory": "player",
			"qty": 1,
			"stack_size": 12,
			"wait_time": 10
		}
}

func _ready():
	$ProgressBar.hide()

func _input(event):
  # Click Machine
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_in_area:
		Autoload.machine_inventory = self

func _on_area_2d_mouse_entered():
	mouse_in_area = true

func _on_area_2d_mouse_exited():
	mouse_in_area = false

# Timer
func _on_slot_1_timeout() -> void:
	if waiting_time.slot1 > 0:
		waiting_time.slot1 -= 1
		$TimerList/Slot1.start()
	else:
		$TimerList/Slot1.stop()
	init_progressbar()
	print(waiting_time.slot1)

func _on_slot_2_timeout():
	if waiting_time.slot2 > 0:
		waiting_time.slot2 -= 1
		$TimerList/Slot1.start()
	else:
		$TimerList/Slot1.stop()
	init_progressbar()
	print(waiting_time.slot2)

func start_machine_timer():
	if queue_item.slot1 and waiting_time.slot1 > 0:
		$TimerList/Slot1.start()
	if queue_item.slot2 and waiting_time.slot2 > 0:
		$TimerList/Slot2.start()

func stop_machine_timer():
	if queue_item.slot1 and waiting_time.slot1 < 1:
		$TimerList/Slot1.stop()
	if queue_item.slot2 and waiting_time.slot2 < 1:
		$TimerList/Slot2.stop()

# Set Waiting Time
func set_waiting_time_slot1(time: int=- 1) -> void:
	if time < 0:
		waiting_time.slot1 = result_item.slot1.wait_time
		return
	waiting_time.slot1 = time
	init_progressbar()

func set_waiting_time_slot2(time: int=- 1) -> void:
	if time < 0:
		waiting_time.slot2 = result_item.slot2.wait_time
		return
	waiting_time.slot2 = time
	init_progressbar()
 
#  Set Item 
func set_item_slot1(item) -> void:
	queue_item.slot1 = item
	if crafting_result.has(item.name):
		set_result_slot1(crafting_result[item.name])
	else:
		set_result_slot1(null)

func set_item_slot2(item) -> void:
	queue_item.slot2 = item
	if crafting_result.has(item.name):
		set_result_slot2(crafting_result[item.name])
	else:
		set_result_slot2(null)

# Set Result
func set_result_slot1(item) -> void:
	result_item.slot1 = item

func set_result_slot2(item) -> void:
	result_item.slot2 = item

# Reset slot
func reset_slot1() -> void:
	queue_item.slot1 = null
	result_item.slot1 = null
	waiting_time.slot1 = -1

func reset_slot2() -> void:
	queue_item.slot2 = null
	result_item.slot2 = null
	waiting_time.slot2 = -1

# ProgressBar
func init_progressbar():
	var result_time: Dictionary = {
		"slot1": 0,
		"slot2": 0
	}
	if result_item.slot1:
		result_time.slot1 = result_item.slot1.wait_time
	if result_item.slot2:
		result_time.slot2 = result_item.slot2.wait_time
	$ProgressBar.show()
	$ProgressBar.min_value = 0
	$ProgressBar.max_value = (result_time.slot1 + result_time.slot2)
	$ProgressBar.value = (waiting_time.slot1 + waiting_time.slot2)