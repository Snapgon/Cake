extends Label


var moving = false


var amount_moved = 0

var called_switch = false

func _process(delta):
	if amount_moved<(rect_size.y+800) and !Input.is_action_just_pressed("ui_accept"):
		if get_parent().running:
			Singleton.god.can_un_pause = false
			moving = true
		if moving:
			rect_position += Vector2(0, -30*delta)
			amount_moved+=30*delta
	else:
		if !called_switch:
			Singleton.god.can_un_pause = true
			Singleton.god.switch_gui("main")
			get_tree().call_group("resetstuff", 'reset')
			called_switch = true
