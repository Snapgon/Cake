extends Button

var new_tween = null

export var offset = Vector2(20,0)
export var main_offset = Vector2.ZERO

func _on_Button_pressed():
	if get_parent().running:
		$AudioStreamPlayer._play()





func _on_Button_focus_entered():
	$AudioStreamPlayer2._play()
	if new_tween != null:
		new_tween.kill()
	new_tween = get_tree().create_tween()
	new_tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(self, "rect_position", offset+main_offset, 0.3 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	


func _on_Button_focus_exited():
	if new_tween != null:
		new_tween.kill()
	
	new_tween = get_tree().create_tween()
	new_tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(self, "rect_position",main_offset, 0.3 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)


func _on_Button_mouse_entered():
	if get_focus_owner() != self:
		grab_focus()
		_on_Button_focus_entered()


