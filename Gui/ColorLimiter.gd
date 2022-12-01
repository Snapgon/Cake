extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Singleton.color_screen.visible == false:
		pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		Singleton.color_screen.visible = false
		$AudioStreamPlayer._play()
	else:
		Singleton.color_screen.visible = true
		$AudioStreamPlayer._play()
