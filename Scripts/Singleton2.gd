extends Node


var money = 0

var bars = null
var has_talked_to_tutorial = false

var cannon_task_done = false
var cannon_reward = false

var hook_task_done = false
var hook_reward = false

var player = null;

onready var base_cake = preload("res://Props/CakePickUp.tscn")
onready var boom_cake = preload("res://Cakes/BoomPickup.tscn")
onready var lmon_cake = preload("res://Cakes/LmonCakePickup.tscn")

func _process(delta):
	if player!=null:
		money = player.money

func charge():
	if Singleton.player !=null and Singleton.money_ui != null:
		Singleton.player.money -=120
		Singleton.money_ui.update_money(Singleton.player.money )
		Singleton.player.change_stamina()

func add_cake():
	if Singleton.game !=null:
		var new_cake = base_cake.instance()
		Singleton.game.add_child(new_cake)
		new_cake.global_translation = Vector3(-11.978,2.544, 200.165)
func spawn_boom_cake():
	if Singleton.game !=null:
		var new_cake = boom_cake.instance()
		Singleton.game.add_child(new_cake)
		new_cake.global_translation = Vector3(-174.4,-0.906, -82.385)

func spawn_lmon_cake():
	if Singleton.game !=null:
		var new_cake = lmon_cake.instance()
		Singleton.game.add_child(new_cake)
		new_cake.global_translation = Vector3(105.821,41.994, 82.645)
