extends Spatial

onready var smoke = preload("res://Props/Appear.tscn")


func _ready():
	Singleton.game = self

func start():
	pass

func make_smoke():
	if Singleton.player!=null:
		var new_smoke = smoke.instance()
		add_child(new_smoke)
		new_smoke.global_translation = Singleton.player.global_translation

func end():
	$AnimationPlayer.play("End")
	Singleton.player.move_mode = 0
func more():
	Singleton.god.grow()

func reset():
	$CanvasLayer/AnimationPlayer.play("RESET")
	Singleton.player.move_mode = 1


