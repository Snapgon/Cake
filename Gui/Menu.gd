extends Control


export var running = true
export var _path = "main"


export var node_path = ""

export var buttons = []


func kill():
	for i in buttons:
		get_node(i).mouse_filter = MOUSE_FILTER_IGNORE
	yield( get_tree().create_timer(0.4), "timeout")
	queue_free()

func enable_buttons():
	running = true
	for i in buttons:
		get_node(i).mouse_filter = MOUSE_FILTER_STOP
	if node_path!= "" :

		var node_focus = get_node(node_path)
		node_focus.call_deferred("grab_focus")
func disable_buttons():
	running = false
	for i in buttons:
		get_node(i).mouse_filter = MOUSE_FILTER_IGNORE


