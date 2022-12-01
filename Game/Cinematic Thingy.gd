extends CanvasLayer


onready var anim = get_node("AnimationPlayer") 
func _ready():
	Singleton2.bars = anim
