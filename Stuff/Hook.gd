extends Spatial




func _ready():
	Singleton.player.connect("Thrown", self, "die")

	
	
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Jump") and Singleton.player.is_on_floor():
		Singleton.player.jump()
		Singleton.player.switch_walk()
		queue_free()
	elif Singleton.player.air_jumps==1 and Input.is_action_just_pressed("Jump"):
		Singleton.player.air_jumps-=1 
		Singleton.player.jump()
		Singleton.player.switch_walk()
		queue_free()
	elif global_translation.distance_to(Singleton.player.global_translation)<1.9:
		Singleton.player.switch_walk()
		queue_free()
	else:
		var vel = global_translation-Singleton.player.global_translation
		vel = vel.normalized()*23
		Singleton.player.move_and_slide(vel)
func _process(delta):
	$ImmediateGeometry.clear()
	
	$ImmediateGeometry.begin(3, null) #1 = is an enum for draw line, null is for text
	$ImmediateGeometry.set_color(Color("2d3142"))
	$ImmediateGeometry.add_vertex(Vector3(0,0,0))
	$ImmediateGeometry.add_vertex(Singleton.player.global_translation- global_translation)
	$ImmediateGeometry.end()




func die(type):
	Singleton.player.switch_walk()
	queue_free()
