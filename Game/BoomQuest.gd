extends Spatial


var i = 0
var running = false
func _process(delta):
	if Singleton.timer_label!= null:
		if running:
			Singleton.timer_label.text = str(stepify($Timer.time_left,0.1))
		else:
			Singleton.timer_label.text = " "


func _up():
	if Singleton2.cannon_task_done == false:
		if running == false:
			running = true
			$Timer.start()
		i+=1
		if i == 3:
			Singleton2.cannon_task_done = true
			$Timer.stop()
			Singleton.timer_label.text = " "
			running = false
		



func _on_Timer_timeout():
	get_tree().call_group("Switches", "_reset")
	running = false
	i = 0
