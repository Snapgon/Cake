extends "res://Gui/BaseButton.gd"


func _on_Button3_pressed():
	._on_Button_pressed()
	if get_parent().running:
		get_tree().quit()
