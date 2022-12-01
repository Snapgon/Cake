extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Nor_Roots_body_entered(body):
	if body.is_in_group("character"):
		body.can_put_down_roots = false


func _on_Nor_Roots_body_exited(body):
	if body.is_in_group("character"):
		body.can_put_down_roots = true
