extends Label



var aa = null

func _ready():
	Singleton.cake_alert = self


func alert():
	$Timer.start()
	modulate = Color("ffffff")


		

func _on_Timer_timeout():
	if aa!=null:
		aa.kill()
	aa = get_tree().create_tween()
	aa.tween_property(self, "modulate", Color("00ffffff"), 0.8).set_ease(Tween.EASE_OUT)
