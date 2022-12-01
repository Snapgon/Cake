extends KinematicBody


export var walk_speed = 5

export var jump_speed = 8
export var acceleration = 15

var grounded = false
var in_air = false
var just_landed = false

export var modifier = 1.75

export var max_stamina = 2
export var current_stamina = 2

var money = 0

var Velocity = Vector3.ZERO
var Direction = Vector3.ZERO

var play_fall = true

var jumping = false

var gravity = 15;

var current_max = walk_speed
var aaaaaaa = current_max
export var jump_buffer = false

var jumped = false

var air_jumps = 1

var z_rotate = 0
var x_rotate = 0

var move_mode = WALK

var moving = false

var can_put_down_roots = true


signal Thrown(aaaaa)



enum {
	DISABLED,
	WALK,
	FLOAT
}
onready var last_position = global_translation

var clouds = preload("res://FX/Clouds.tscn")

onready var mesh = get_node("Player")
onready var cakecontroller = get_node("CakeBrain")


func _ready():
		Singleton.player = self 
		Singleton2.player = self 



func _physics_process(delta):
	if move_mode != DISABLED:
		current_max = min(current_max, walk_speed *2.5)
		
		
		if is_on_floor():
			

				
			
			
			if just_landed:
				just_landed = false
				jumped = false
				
			grounded = true
			
			if in_air == true :
				in_air = false
				just_landed = true
				$Player/AnimationPlayer.play("Ground")
				if play_fall and Velocity.y<-1.5:
					$AudioPlayer/AudioStreamPlayer3._play()
					play_fall = false
					$Timer2.start()
			
			
			
			if just_landed:
				aaaaaaa = walk_speed
			if current_max>aaaaaaa:
				current_max = move_toward(current_max, aaaaaaa, delta)
			if air_jumps<1:
				air_jumps = 1
			if Input.is_action_just_pressed("Jump") or jump_buffer:
				jump()
				Velocity.y = jump_speed
			else:
				jumping = false
			
			
			
		else:
			
			if jumping:
				Velocity.y = jump_speed
				if Input.is_action_just_released("Jump"):
					jumping = false
			
			
			if (!jumped or is_on_wall()) and !jumping:
				Velocity.y = min(-0.6, Velocity.y)
				Velocity.y -= gravity*delta*4
			
			
			if just_landed:
				just_landed = false
				
			if grounded:
				grounded =false
				$Player/AnimationPlayer.play("Jump")
			
			in_air = true
			Velocity.y -= gravity*delta
			if air_jumps==1 and Input.is_action_just_pressed("Jump"):
				air_jumps-=1
				jump()
				
			elif  Input.is_action_just_pressed("Jump") :
				jump_buffer = true
				$JumpBuffer.start()

		if Input.is_action_just_pressed("Surf") and move_mode == WALK:
			move_mode = FLOAT
			current_max = walk_speed*modifier
			$AnimationPlayer.play("Float")
			$AudioPlayer/AudioStreamPlayer4._play()
		elif Input.is_action_just_released("Surf") and move_mode == FLOAT: 
			unsurf()
			

		
		
		if move_mode == WALK:
			current_stamina += delta/2
			current_stamina = clamp(current_stamina, 0, max_stamina)
			var input_vel = Vector2.ZERO
			if Input.is_action_pressed("Forward"):
				input_vel.y = 1
				
			elif Input.is_action_pressed("Back"):
				input_vel.y = -1

			if Input.is_action_pressed("Left"):
				input_vel.x = -1
			elif Input.is_action_pressed("Right"):
				input_vel.x = 1
			if input_vel == Vector2.ZERO or in_air:
				$Particles.emitting = false
				moving = false
			else:
				$Particles.emitting = true
				moving = true
				if !$Player/AnimationPlayer.is_playing():
					$Player/AnimationPlayer.play("Walk")
			
			
			input_vel = input_vel.limit_length(1)
			Direction = Vector3.ZERO
			var basis:Basis = $Spatial2/Camera.global_transform.basis
			Direction+=-basis.z*input_vel.y
			Direction+=basis.x*input_vel.x
			Direction = Direction.normalized()
			
			
			var current_acceleration = Velocity.linear_interpolate(Direction*current_max, acceleration*delta)
			
			
			if grounded and Velocity.y != jump_speed and !jumping:
				Velocity.y =0
				move_and_collide( Vector3.UP * Velocity.y - get_floor_normal()*.01)
				Velocity = move_and_slide_with_snap(Vector3(current_acceleration.x, Velocity.y, current_acceleration.z) , Vector3.DOWN, Vector3.UP,true)
			else:
				Velocity = move_and_slide(Vector3(current_acceleration.x, Velocity.y, current_acceleration.z), Vector3.UP)
			
			_rotate(delta)
			z_rotate = move_toward(z_rotate, 0, delta)
			x_rotate = move_toward(x_rotate, 0, delta)
		else:
			current_stamina -=delta/2
			if(current_stamina <=0):
				unsurf()
			current_stamina = clamp(current_stamina, 0, max_stamina)
			var input_vel = Vector2.ZERO
			if Input.is_action_pressed("Forward"):
				input_vel.y = 1.0
			elif Input.is_action_pressed("Back"):
				input_vel.y = -1.0
				
			if Input.is_action_pressed("Left"):
				input_vel.x = -1.0
			elif Input.is_action_pressed("Right"):
				input_vel.x = 1.0
			
			if input_vel == Vector2.ZERO or in_air:
				$Particles.emitting = false
			else:
				$Particles.emitting = true


			input_vel = input_vel.limit_length(1)
			
			var basis:Basis = $Spatial2/Camera.global_transform.basis

			if input_vel.y!=0 and Velocity.y != jump_speed:
				Direction+=-basis.z*input_vel.y*delta*1.5
			elif Velocity.y == jump_speed:
				Direction=-basis.z*input_vel.y
			elif input_vel.y == 0 and input_vel.x == 0:
				Direction.z = move_toward(Direction.z, 0, delta*1.5)


			if input_vel.x!=0 and Velocity.y != jump_speed:
				Direction+=basis.x*input_vel.x*delta*1.5
			elif Velocity.y == jump_speed:
				Direction=basis.x*input_vel.x
			elif input_vel.y == 0 and input_vel.x == 0:
				Direction.x = move_toward(Direction.x, 0, delta)
			
			Direction = Direction.limit_length(1)
			var current_acceleration = Velocity.linear_interpolate(Direction*current_max, acceleration*delta)
			
			if grounded and Velocity.y != jump_speed and !jumping:
				Velocity.y =0
				move_and_collide( Vector3.UP * Velocity.y - get_floor_normal()*.01)
				Velocity = move_and_slide_with_snap(Vector3(current_acceleration.x, Velocity.y, current_acceleration.z), Vector3.DOWN, Vector3.UP,true)
			else:
				Velocity = move_and_slide(Vector3(current_acceleration.x, Velocity.y, current_acceleration.z), Vector3.UP)
			
			_rotate(delta)
			z_rotate = move_toward(z_rotate, -Direction.z, delta)
			x_rotate = move_toward(x_rotate, Direction.x, delta)
		$Spatial2.rotation_degrees = $Player.rotation_degrees
		if is_on_floor() and can_put_down_roots and Velocity.y>=0 and ! is_on_wall() and get_floor_angle()<0.3:
			last_position = global_translation
		


func _rotate(delta):
	$Player.rotation_degrees.x = 0
	$Player.rotation_degrees.z = 0
	$Player.rotate_z(-deg2rad( x_rotate*10))
	$Player.rotate_x(-deg2rad(z_rotate*10))
	$"Interactive Controller".rotation  = $Player.rotation
	var to_angle = Vector2(Direction.x, -Direction.z).angle()
	if Vector2(Direction.x, Direction.z)!=Vector2.ZERO:
		if to_angle<0:
			to_angle = 2*PI+to_angle
		#if $Player.rotation.y <0:
		#	$Player.rotation.y  = PI+ $Player.rotation.y 
		if to_angle !=  $Player.rotation.y:
			$Player.rotation.y = lerp_angle($Player.rotation.y ,Vector2(-Direction.x, Direction.z).angle(),4*delta)
	
				
func _on_JumpBuffer_timeout():
	jump_buffer = false


func unsurf():
	move_mode = WALK
	current_max = walk_speed
	$AnimationPlayer.play("Unfloat")


func switch_walk():
	move_mode = WALK
	current_max = walk_speed
	if($Player.translation.y !=-1.299):
		var twe = get_tree().create_tween()
		twe.tween_property($Player, "translation", Vector3(0,-1.299,0), 0.546448*($Player.translation.y)+0.709836)


func jump():
	
	if move_mode == FLOAT:
		aaaaaaa = current_max*1.25
		current_max = aaaaaaa
	var new_cloud = clouds.instance()
	get_parent().add_child(new_cloud)
	new_cloud.translation = global_translation+Vector3(0,-0.7,0)
	jumped = true
	jumping = true
	$Timer.start()
	$AudioPlayer/AudioStreamPlayer2._play()

func change_stamina():
	max_stamina+=1
	current_stamina = max_stamina
	Singleton.stamina.change()

func _on_Timer_timeout():
	jumping = false

func add_cake(type):
	Singleton.cake_alert.alert()
	if cakecontroller.current_cake == cakecontroller.None:
		if type == 'Base':
			cakecontroller.current_cake = cakecontroller.Base
		elif type == "Boom":
			cakecontroller.current_cake = cakecontroller.Explosive
		else:
			cakecontroller.current_cake = cakecontroller.Hook
		cakecontroller._add_cake_model()
	if type == "Base":
		if !cakecontroller.unlocked.has(cakecontroller.Base):
			cakecontroller.unlocked.insert(0,cakecontroller.Base)
	elif type == "Boom":
		if !cakecontroller.unlocked.has(cakecontroller.Explosive):
			cakecontroller.unlocked.append(cakecontroller.Explosive)
	else:
		if !cakecontroller.unlocked.has(cakecontroller.Hook):
			cakecontroller.unlocked.append(cakecontroller.Hook)
	$AudioPlayer/AudioStreamPlayer6._play()
		
func DIE():
	global_translation = last_position
	air_jumps = 1
	$AudioPlayer/AudioStreamPlayer._play()


func _on_Timer2_timeout():
	play_fall = true


func check():
	if move_mode == FLOAT:
		if !Input.is_action_pressed("Surf"):
			unsurf()

func explode():
	$AudioPlayer/AudioStreamPlayer5._play()
