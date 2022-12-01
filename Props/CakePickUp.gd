extends Spatial


export var type = "Base"


func _ready():
	if Singleton.game !=null:
		var new_smoke = Singleton.game.smoke.instance()
		Singleton.game.add_child(new_smoke)
		new_smoke.global_translation = global_translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	
	Singleton.player.add_cake(type)
	if Singleton.game !=null:
		var new_smoke = Singleton.game.smoke.instance()
		Singleton.game.add_child(new_smoke)
		new_smoke.global_translation = global_translation
	queue_free()
