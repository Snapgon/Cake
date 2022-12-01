extends Camera

var max_offset = 1.0


export var height = 9
export var x_ = 16


func _ready():
	set_as_toplevel(true)


var offset = Vector2(0.0,0.0)

func _process(delta):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0,1,0)
	var offset = pos-target
	offset = offset.normalized()*x_
	offset.y = height
	pos = target+offset
	look_at_from_position(pos,target, up)
	
	
	
