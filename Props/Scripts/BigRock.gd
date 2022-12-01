extends Spatial

var health = 5
var killed = false
func die():
	health -=1
	
	if health == 0 :
		Singleton.game.end()
	elif health>0:
		var new_tween = get_tree().create_tween()
		new_tween.tween_property($MeshInstance.mesh, "size", Vector2($MeshInstance.mesh.size.x*2,$MeshInstance.mesh.size.y*2), 0.4).set_trans(Tween.TRANS_CIRC)
	killed = false
	
func reset():
	health = 5
	killed = false
	$MeshInstance.mesh.size = Vector2(0.2,0.2)
