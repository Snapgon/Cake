extends HSlider


func _ready():
	value = Singleton.music_scale*100.0


func _on_HSlider_drag_ended(value_changed):
	if value_changed:
		Singleton.music_scale = value/100.0
		$AudioStreamPlayer._play()


func _on_HSlider_drag_started():
	$AudioStreamPlayer2._play()
