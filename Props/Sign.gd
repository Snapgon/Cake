extends Spatial

export var which_sign = "Base_Sign"

func _ready():
	$StaticBody.which_sign = which_sign
