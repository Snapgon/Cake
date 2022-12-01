extends Node

var  holding = true

var throwing = false

enum {
	None, 
	Base,
	Explosive,
	Hook
}

var switch_buffered = false


onready var cake_player = get_parent().get_node("Player/Arm Animation")

onready var BaseCake = preload("res://Cakes/BaseCake.tscn")
onready var BaseCakeModel = preload("res://Models/Cake.tscn")
onready var LemonCake = preload("res://Cakes/LemonCake.tscn")
onready var LemonCakeModel = preload("res://Models/LmonCake.tscn")
onready var RedCakeModel = preload("res://Models/RedVelvetCake.tscn")
onready var RedCake = preload("res://Cakes/RedVelvetCake.tscn")
var unlocked = []
var current_cake = None

func _ready():
	if current_cake != None:
		_add_cake_model()


func _physics_process(delta):
	if holding == true and Input.is_action_just_pressed("Throw") and $CakeCooldown.is_stopped() and unlocked.size()>0:
		Throw()
	elif get_parent().move_mode == get_parent().WALK  and holding and !throwing and get_parent().moving and cake_player.is_playing() == false:
		cake_player.play("Walk") 
	
	if throwing == false and holding == true and (Input.is_action_just_pressed("SwitchCake") or switch_buffered) and unlocked.size()>0:
		var found = false
		for i in unlocked:
			if found:
				current_cake = i
				found = false
				break
			if i == current_cake:
				found = true
		if found:
			current_cake = unlocked[0]
		get_parent().get_node("Player/Hands").get_child(0).queue_free()
		_add_cake_model()
		switch_buffered = false
	elif Input.is_action_just_pressed("SwitchCake") and unlocked.size()>0:
		switch_buffered = true
		$SwitchBuffer.start()
			
				
		
	

func _on_CakeCooldown_timeout():
	holding = true
	throwing = false
	_add_cake_model()


func _add_cake_model():
	if current_cake == Base:
		var new_cake = BaseCakeModel.instance()
		get_parent().get_node("Player/Hands").add_child(new_cake)
		new_cake.scale = Vector3(0.4,0.4,0.4)
		new_cake.rotation_degrees = Vector3(18.526,-141.669,14.102)
		new_cake.translation = Vector3(-0.004,-0.25,-0.398)
	elif current_cake == Hook:
		var new_cake = LemonCakeModel.instance()
		get_parent().get_node("Player/Hands").add_child(new_cake)
		new_cake.scale = Vector3(0.4,0.4,0.4)
		new_cake.rotation_degrees = Vector3(18.526,-141.669,14.102)
		new_cake.translation = Vector3(-0.004,-0.25,-0.398)
	elif current_cake == Explosive:
		var new_cake = RedCakeModel.instance()
		get_parent().get_node("Player/Hands").add_child(new_cake)
		new_cake.scale = Vector3(0.4,0.4,0.4)
		new_cake.rotation_degrees = Vector3(18.526,-141.669,14.102)
		new_cake.translation = Vector3(-0.004,-0.25,-0.398)

func Throw():
	$Timer.start()
	throwing  = true
	$CakeCooldown.start()
	cake_player.play("Throw") 

func finishthrowing():
	get_parent().get_node("Player/Hands").get_child(0).queue_free()
	cake_player.play("ThowBack") 
	holding = false
	var new_cake 
	if current_cake == Base:
		new_cake = BaseCake.instance()
	elif current_cake == Hook:
		new_cake = LemonCake.instance()
	elif current_cake == Explosive:
		new_cake = RedCake.instance()
	
	
	new_cake.scale = Vector3(0.8,0.8,0.8)
	new_cake.rotate_y(get_parent().get_node("Player").rotation.y+PI)
	new_cake.translation = get_parent().get_node("Player/Position3D").global_translation
	
	get_parent().get_parent().add_child(new_cake)
	get_parent().emit_signal("Thrown",new_cake )
	


func _on_Timer_timeout():
	finishthrowing()


func _on_SwitchBuffer_timeout():
	switch_buffered = false
