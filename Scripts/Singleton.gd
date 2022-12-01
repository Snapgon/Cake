extends Node

var god = null;
var stamina = null
var player = null;
var money_ui = null;
var dialogue_ui = null;
var game = null
var interact_thing  = null
var music_controller = null
var cake_alert = null
var timer_label = null
var color_screen


var hook = preload("res://Stuff/Hook.tscn")
var explode = preload("res://Cakes/Explosion.tscn")

var stars = preload("res://FX/Stars.tscn")
var spikes = preload("res://FX/Spikes.tscn")


onready var clouds = preload("res://FX/Cloud.tscn")
onready var coin = preload("res://FX/Coin.tscn")

# Load the custom images for the mouse cursor.
var arrow = load("res://Stuff to delete later/Cursor.png")
var clicker = load("res://Stuff to delete later/Clicker.png")

var music_scale = 0.7
var sfx_scale = 0.9
var total_scale = 0.7
export var audio_bus_name := "SFX"
export var audio_bus_name2 := "Music"
export var audio_bus_name3 := "Master"
onready var _bus := AudioServer.get_bus_index(audio_bus_name)
onready var _bus2 := AudioServer.get_bus_index(audio_bus_name2)
onready var _bus3 := AudioServer.get_bus_index(audio_bus_name3)

var value
var value2
var value3

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	value = db2linear(AudioServer.get_bus_volume_db(_bus))
	AudioServer.set_bus_volume_db(_bus, linear2db(0.7))
	value2 = db2linear(AudioServer.get_bus_volume_db(_bus2))
	AudioServer.set_bus_volume_db(_bus2, linear2db(0.7))
	value3 = db2linear(AudioServer.get_bus_volume_db(_bus3))
	AudioServer.set_bus_volume_db(_bus3, linear2db(0.7))
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow)

	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(clicker, Input.CURSOR_POINTING_HAND)


func _process(delta):
	
	AudioServer.set_bus_volume_db(_bus, linear2db(sfx_scale))
	AudioServer.set_bus_volume_db(_bus2, linear2db(music_scale))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(total_scale))
