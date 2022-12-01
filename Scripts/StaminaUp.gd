extends Sprite3D


func _on_Area_body_entered(body):
	Singleton.player.change_stamina()
	queue_free()
