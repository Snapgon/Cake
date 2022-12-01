extends StaticBody

var interactable = true

export var text :String  = "res://Props/Signs.tres"
onready var diaogue = load(text)
var which_sign = "Base_Sign"

var in_focus = false

func Interact():
	if Singleton.dialogue_ui.currently_talking == false:
		Singleton.dialogue_ui.talk(diaogue, which_sign)
		Singleton.player.move_mode = 0
