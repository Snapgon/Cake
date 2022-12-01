extends Area


export var music  = "track1"
func _on_Area_body_entered(body):
	if body.is_in_group("character"):
		Singleton.music_controller._switch(music )
