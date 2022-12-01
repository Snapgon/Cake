extends AudioStreamPlayer


export (float) var variation = 0.1
export (float) var normal_range = 1

func _play():
	pitch_scale = normal_range
	pitch_scale+=rand_range(-variation, variation)
	play()

