extends Area





func die():
	force_update_transform()
	for i in get_overlapping_bodies():
		
		i.get_parent().die()
	queue_free()


func _on_Area_body_entered(body):
	if !body.get_parent().killed:
		body.get_parent().killed = true
		body.get_parent().die()
