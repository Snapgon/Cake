extends AudioStreamPlayer


var new_tween = null 
export var is_menu  =false

func _focus():
	if new_tween!=null:
		new_tween.kill()
	new_tween = get_tree().create_tween()
	
	new_tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(self, "volume_db", 0.0, 0.8).set_trans(Tween.TRANS_CIRC)
	
func _unfocus():
	if new_tween!=null:
		new_tween.kill()
	new_tween = get_tree().create_tween()
	
	new_tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(self, "volume_db", -80.0, 0.8).set_trans(Tween.TRANS_CIRC)
