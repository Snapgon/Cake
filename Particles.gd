extends Particles


export var time = 1.0
func _ready():
	$Timer.wait_time = time
	$Timer.start()
	emitting  = true





func _on_Timer_timeout():
	queue_free()
