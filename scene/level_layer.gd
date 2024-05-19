extends CanvasLayer

var mouse_on_leftbar: bool = false

func _on_level_popup_mouse_on_leftbar():
	mouse_on_leftbar = true

func _on_level_popup_mouse_out_leftbar():
	mouse_on_leftbar = false
