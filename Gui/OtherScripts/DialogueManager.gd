extends Control

var currently_talking = false
var current_talk = null
signal aaaaaaaaa

func _ready():
	Singleton.dialogue_ui = self 

func talk(new_talk, line):
	if current_talk == new_talk:
		$AudioStreamPlayer2._play()
	current_talk = new_talk
	currently_talking = true
	var dia_line =  yield( new_talk.get_next_dialogue_line( line),  "completed")
	if dia_line !=null:
		var dialogue_balloon = preload("res://Gui/Balloon.tscn")
		var balloo = dialogue_balloon.instance()
		balloo.get_node("Margin/VBox/DialogueLabel").dialogue = dia_line
		balloo.get_node("Margin/VBox/Character").visible = dia_line.character != ""
		balloo.get_node("Margin/VBox/Character").bbcode_text = " "+dia_line.character
		add_child(balloo)
		balloo.dialogue = dia_line
		balloo.ghvjhgvjhgvhgv()
		
	else:
		current_talk = null
		currently_talking = false
		Singleton.player.switch_walk()
		emit_signal("aaaaaaaaa")

func check(bool_):
	if get_child_count()!=1:
		if get_child(1).get_node("Margin/VBox/Responses").visible:
			if bool_:
				get_child(1).get_node("Margin/VBox/Responses/RichTextLabel0").mouse_filter = MOUSE_FILTER_IGNORE
				get_child(1).get_node("Margin/VBox/Responses/RichTextLabel1").mouse_filter= MOUSE_FILTER_IGNORE
			else:
				get_child(1).get_node("Margin/VBox/Responses/RichTextLabel0").mouse_filter= MOUSE_FILTER_STOP
				get_child(1).get_node("Margin/VBox/Responses/RichTextLabel1").mouse_filter= MOUSE_FILTER_STOP
				
				get_child(1).get_node("Margin/VBox/Responses/RichTextLabel0").call_deferred("grab_focus")

func continue(cont):
	if current_talk!=null:
		talk(current_talk,cont)
		
