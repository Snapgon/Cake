extends Spatial

var thrown = false
export  var nature: int = Base 

export var speed = 10

export var time = 1.2


var frame_1 = 5

enum {
	Base,
	Exploive,
	Hook
}

func _ready():
	$Timer.wait_time = time




func _physics_process(delta):
	if frame_1>0:
		for i in $Area3.get_overlapping_areas():
			if i.is_in_group("Wall"):
				queue_free()
		frame_1 -=1
	global_translation+=Vector3(speed*delta,0,0).rotated(Vector3(0,1,0), rotation.y)
	

func die():
	if nature == Hook:
		var new_hook  = Singleton.hook.instance()
		get_parent().add_child(new_hook)
		new_hook.global_translation = global_translation
		
		Singleton.player.move_mode = 0
	elif nature == Exploive:
		var new_bpoom  = Singleton.explode.instance()
		get_parent().add_child(new_bpoom)
		new_bpoom.global_translation = global_translation
		var new_star = Singleton.stars.instance()
		get_parent().add_child(new_star)
		new_star.global_translation =global_translation
		var new_spike = Singleton.spikes.instance()
		get_parent().add_child(new_spike)
		new_spike.global_translation =global_translation
		Singleton.player.explode()
	else:
		var new_spike = Singleton.clouds.instance()
		get_parent().add_child(new_spike)
		new_spike.global_translation =global_translation
	queue_free()


func _on_Timer_timeout():
	if nature == Exploive:
		var new_bpoom  = Singleton.explode.instance()
		get_parent().add_child(new_bpoom)
		new_bpoom.global_translation = global_translation
		var new_star = Singleton.stars.instance()
		get_parent().add_child(new_star)
		new_star.global_translation =global_translation
		var new_spike = Singleton.spikes.instance()
		get_parent().add_child(new_spike)
		new_spike.global_translation =global_translation
		Singleton.player.explode()
	else:
		var new_spike = Singleton.clouds.instance()
		get_parent().add_child(new_spike)
		new_spike.global_translation =global_translation
	queue_free()





func _on_Area3_body_entered(body):
	if body.is_in_group("Wall"):
		die()
