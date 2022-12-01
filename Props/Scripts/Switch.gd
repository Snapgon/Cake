extends StaticBody

var interactable = true

export var num =0


var in_focus = false

var on = false

func Interact():
	if on == false:
		on = true
		get_parent().get_surface_material(1).set_shader_param("base_color", Color("a30000"))
		if get_parent().rotation_degrees.y ==0:
			get_parent().rotation_degrees.y = 180
		on = true
		get_parent().get_parent().get_parent()._up()
		interactable = false
	
func _reset():
	get_parent().get_surface_material(1).set_shader_param("base_color", Color("23bbbe"))
	on = false
	get_parent().rotation_degrees.y =0
	interactable = true
