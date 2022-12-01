extends Control

var new_tweeen  = null
var hidden = true 
func _ready():
	Singleton.interact_thing = self


func reveal():
	hidden = false
	
	if new_tweeen != null:
		new_tweeen.kill()
	new_tweeen  = get_tree().create_tween()
	new_tweeen.tween_property($TextureRect, "rect_scale", Vector2(0.2,0.2), 0.3 ).set_trans(Tween.TRANS_CIRC)
	
func hide():
	hidden = true
	if new_tweeen != null:
		new_tweeen.kill()
	new_tweeen  = get_tree().create_tween()
	new_tweeen.tween_property($TextureRect, "rect_scale", Vector2(0,0), 0.3 ).set_trans(Tween.TRANS_CIRC)
	
