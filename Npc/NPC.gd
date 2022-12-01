extends KinematicBody

var money_given = false
export var money_amount = 30

export var cake_type = 0

export var quest_npc = false

enum type_{
	TALK,
	MONEY
	
	
}

export (type_) var mode = type_.MONEY

export var text :String  = "res://Npc/Npc Dialogues/Test1.tres"
onready var diaogue = load(text)
export var line = "Sell"


var moving_paused = false

var in_focus = false

export var moving = true
var current_one = null

var interactable = false

func _ready():
	if !quest_npc:
		$NPC.visible = false
		$NPC2.visible = true
	
	if mode == type_.TALK:
		interactable = true
	if moving == true:
		current_one = $Spatial.get_child(0)


func _physics_process(delta):
	if moving and !moving_paused:
		var previous = global_translation
		var moveing = Vector3(3,0,0).rotated(Vector3(0,1,0), Vector2(-global_translation.x,global_translation.z).angle_to_point(Vector2(-current_one.global_translation.x, current_one.global_translation.z)))
		moveing = move_and_slide(moveing)
		var new = global_translation
		$Spatial.translation += (previous-new)
		if global_translation.distance_to(current_one.global_translation)<0.2:
			var found = false
			var _previous = current_one
			for i in $Spatial.get_children():
				if found:
					current_one = i
					break
				if i == current_one:
					found = true
			if _previous == current_one:
				current_one = $Spatial.get_child(0)
	


func Interact():
	if Singleton.dialogue_ui.currently_talking == false:
		Singleton.dialogue_ui.talk(diaogue, line)
		Singleton.player.move_mode = 0
		moving_paused = true
		Singleton.dialogue_ui.connect("aaaaaaaaa", self, "stop")

func stop():
	moving_paused = false
	Singleton.dialogue_ui.disconnect("aaaaaaaaa", self, "stop")


func _on_Area_area_entered(area):
	if area.get_parent().is_in_group("Cake"):
		if mode == type_.MONEY:
			if cake_type ==  area.get_parent().nature and !money_given:
				area.get_parent().die()
				money_given = true
				Singleton.player.money +=money_amount
				Singleton.money_ui.update_money(Singleton.player.money )
				$Sprite3D.texture = load("res://Stuff to delete later/Check.png")
