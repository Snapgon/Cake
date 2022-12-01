extends "res://Gui/BaseButton.gd"



func _on_Button_pressed():
	
	._on_Button_pressed()
	if get_parent().running:
		Singleton.god.start_game()
