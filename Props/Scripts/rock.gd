extends Spatial


onready var money = preload("res://Props/Money.tscn")

var killed = false

func die():
	var new_money = money.instance()
	
	get_parent().add_child(new_money)
	new_money.set_name(new_money.get_name()+"-lod1")
	new_money.global_translation = global_translation+Vector3(0,20,0)
	get_parent().global_translation+=Vector3(0,2,0)
	
	queue_free()
