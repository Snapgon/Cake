extends "res://Gui/BaseButton.gd"

export var switch_to = "main"

func _on_Button_pressed():
	._on_Button_pressed()
	if get_parent().running:
		Singleton.god.switch_gui(switch_to)
	
