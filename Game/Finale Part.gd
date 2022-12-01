extends Spatial


var running = false
var finished = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if Singleton.timer_label!= null:
		if running:
			Singleton.timer_label.text = str(stepify($Timer.time_left,0.1))
		else:
			Singleton.timer_label.text = " "


func _on_Area_body_entered(body):
	running = true
	$Timer.start()
	if get_parent().get_node("BoomQuest").running:
		get_tree().call_group("Switches", "_reset")
		get_parent().get_node("BoomQuest").running = false
		get_parent().get_node("BoomQuest").i = 0
		get_parent().get_node("BoomQuest/Timer").stop()


func _on_Area_body_exited(body):
	running = false
	$Timer.stop()
	


func _on_Timer_timeout():
	running = false
	Singleton.player.global_translation = $Spatial.global_translation


func _on_Area2_area_entered(area):
	running = false
	$Timer.stop()


func _on_Area2_body_entered(body):
	running = false
	$Timer.stop()
