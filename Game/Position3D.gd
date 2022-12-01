extends Position3D

func _ready():
	get_parent().get_node("Rocks").target_node = get_parent().get_node("Position3D")
	get_parent().get_node("Signs").target_node = get_parent().get_node("Position3D")
	get_parent().get_node("Coins").target_node = get_parent().get_node("Position3D")
	get_parent().get_node("StaminaUps").target_node = get_parent().get_node("Position3D")
	get_parent().get_node("Props").target_node = get_parent().get_node("Position3D")

func _physics_process(delta):
	global_translation = Singleton.player.global_translation
