extends Control

onready var base_camera = $Camera2D
onready var anim_player = $AnimationPlayer
onready var cover = $ColorRect 

var mode = MAIN
enum{
	PLAYING,
	PAUSED,
	MAIN,
	CREDITS
}

var can_un_pause  = true

onready var main_menu = preload("res://Gui/Main Menu.tscn")
onready var  pause_menu = preload("res://Gui/Pause Menu.tscn")
onready var options = preload("res://Gui/Options.tscn")
onready var credits = preload("res://Gui/Credits.tscn")
onready var guis = {"main" : main_menu, "pause" : pause_menu, "options" : options, "Credits":credits}




var previous_scene = null
var previous_scene_path = null
onready var current_scene = get_node("ColorRect/Main Menu")


func _ready():
	Singleton.god = self
	get_tree().paused = true
	$MusicPlayer/Menu._focus()
	current_scene.enable_buttons()

func _process(delta):
	if mode != MAIN and Input.is_action_just_pressed("ui_cancel"):
		pause_()


func pause_():
	if get_tree().paused and can_un_pause:
		unpause()
	elif can_un_pause:
		pause()

func unpause():
	get_tree().paused = false
	$AnimationPlayer.play("InterpolateOut")
	
	current_scene.disable_buttons()
	var new_tween = get_tree().create_tween()
	new_tween.tween_property(current_scene, "modulate", Color("00ffffff"), 0.3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	$MusicPlayer/Menu._unfocus()
	$MusicPlayer._focus()
	Singleton.dialogue_ui.check(false)
	mode = PLAYING
	get_tree().call_group("check","check")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("InterpolateIn")
	
	current_scene.enable_buttons()
	var new_tween = get_tree().create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(current_scene, "modulate", Color("ffffff"), 0.3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	$MusicPlayer/Menu._focus()
	$MusicPlayer._unfocus()
	Singleton.dialogue_ui.check(true)
	mode = PAUSED

func switch_gui(_path):
	checks(_path)
	var new_menu = guis[_path].instance()
	$ColorRect.add_child(new_menu)
	var was_there = false
	
	if previous_scene and new_menu._path ==previous_scene_path  and new_menu._path != "options"  :
		was_there = true
	
	previous_scene = current_scene
	previous_scene.running = false
	previous_scene.disable_buttons()
	previous_scene_path = previous_scene._path
	
	current_scene = new_menu
	if was_there == false:
		current_scene.rect_position = Vector2(1280,0)
	else:
		current_scene.rect_position = Vector2(-1280,0)
	
	var new_tween = get_tree().create_tween().set_parallel(true).set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	if was_there == false:
		new_tween.tween_property(previous_scene, "rect_position", Vector2(-1280,0), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
		new_tween.tween_property(current_scene, "rect_position", Vector2(0,0), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
		
	else:
		new_tween.tween_property(previous_scene, "rect_position", Vector2(1280,0), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
		new_tween.tween_property(current_scene, "rect_position", Vector2(0,0), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	previous_scene.kill()
	if get_tree().paused == true:
		current_scene.enable_buttons()
	

func fast_switch_gui(_path):
	checks(_path)
	var new_menu = guis[_path].instance()
	$ColorRect.add_child(new_menu)
	
	
	previous_scene = current_scene
	previous_scene.running = false
	previous_scene.disable_buttons()
	previous_scene_path = previous_scene._path
	
	current_scene = new_menu
	current_scene.rect_position = Vector2(0,0)

	
	previous_scene.queue_free()
	if get_tree().paused ==  false:
		current_scene.modulate =  Color("00ffffff")
		current_scene.running = false
		current_scene.disable_buttons()
	else:
		current_scene.modulate =  Color("ffffff")
		current_scene.ensable_buttons()


func checks(_path):
	if _path == "main":
		if mode == PAUSED or mode == PLAYING:
			mode = MAIN



func start_game():
	get_tree().paused = false
	$AnimationPlayer.play("InterpolateOut")
	
	
	var new_tween = get_tree().create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	new_tween.tween_property(current_scene, "modulate", Color("00ffffff"), 0.3)
	$"Main Game/Viewport/Game".start()
	$MusicPlayer/Menu._unfocus()
	$MusicPlayer._focus()
	current_scene.disable_buttons()
	Singleton.dialogue_ui.check(false)
	mode = PLAYING
	get_tree().call_group("check","check")
	
func grow():
	$Control/AnimationPlayer.play("Grow")

func reset():
	$Control/AnimationPlayer.play("RESET")
