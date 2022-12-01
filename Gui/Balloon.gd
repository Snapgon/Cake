extends NinePatchRect

onready var label = get_node("Margin/VBox/DialogueLabel")
onready var chara = get_node("Margin/VBox/Character")

var has_started = false

signal actioned(next_id)

var dialogue = null

var finished = false

var can_speak  = true

func ghvjhgvjhgvhgv():
	
	label.type_out()
	has_started = true



	



func _process(delta):
	if $Margin/VBox/DialogueLabel.percent_visible == 1 and has_started and  dialogue !=null and dialogue.responses.size() == 0:
		
		$TextureRect.rect_position.y = -10
		$TextureRect.rect_position.x = 600
		
		$AnimationPlayer.root_node = get_path()
		$AnimationPlayer.play("dle")
	elif $Margin/VBox/DialogueLabel.percent_visible == 1 and !finished and has_started and  dialogue !=null and dialogue.responses.size() > 0:
		var i = 0
		for response in dialogue.responses:
			if i!=2:
				if i == 0:
					$Margin/VBox/Responses/RichTextLabel0.bbcode_text = response.prompt
					$Margin/VBox/Responses/RichTextLabel0.mouse_filter = MOUSE_FILTER_STOP
				else:
					$Margin/VBox/Responses/RichTextLabel1.bbcode_text = response.prompt
					$Margin/VBox/Responses/RichTextLabel1.mouse_filter = MOUSE_FILTER_STOP
				i+=1
		cknfiiajhf()
		$Margin/VBox/Responses.visible = true
		finished = true
	
	if can_speak and  !finished and has_started and $Margin/VBox/DialogueLabel.percent_visible != 1:
		$AudioStreamPlayer._play()
		can_speak = false 
		$Timer.start()
	elif can_speak:
		$AudioStreamPlayer.stop()
		
	if $Margin/VBox/Responses.visible and Input.is_action_just_pressed("Interact") and $Margin/VBox/Responses/RichTextLabel0.mouse_filter == MOUSE_FILTER_STOP:
		if get_focus_owner() == $Margin/VBox/Responses/RichTextLabel0:
			Singleton.dialogue_ui.continue( dialogue.responses[0].next_id)
			queue_free()
		elif  get_focus_owner() == $Margin/VBox/Responses/RichTextLabel1 and $Margin/VBox/Responses/RichTextLabel1.mouse_filter == MOUSE_FILTER_STOP:
			Singleton.dialogue_ui.continue( dialogue.responses[1].next_id)
			queue_free()
		
func cknfiiajhf():
	$Margin/VBox/Responses/RichTextLabel0.grab_focus()

func _on_response_mouse_entered(item):
	
	item.grab_focus()


func _on_response_gui_input(event, item):
	if true: return
	
	#if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
	#	next(dialogue.responses[item.get_index()].next_id)
	#elif event.is_action_pressed("ui_accept") and item in get_responses():
	#	next(dialogue.responses[item.get_index()].next_id)



func _on_RichTextLabel0_mouse_entered():
	$Margin/VBox/Responses/RichTextLabel0.grab_focus()


func _on_RichTextLabel1_mouse_entered():
	$Margin/VBox/Responses/RichTextLabel1.grab_focus()

 
func _on_RichTextLabel0_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1 and $Margin/VBox/Responses/RichTextLabel0 == get_focus_owner() :
		Singleton.dialogue_ui.continue( dialogue.responses[0].next_id)
		queue_free()
	elif false and (event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"))and $Margin/VBox/Responses/RichTextLabel0 == get_focus_owner() :
		Singleton.dialogue_ui.continue( dialogue.responses[0].next_id)
		queue_free()


func _on_RichTextLabel1_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1 and $Margin/VBox/Responses/RichTextLabel1 == get_focus_owner():
		Singleton.dialogue_ui.continue(dialogue.responses[1].next_id)
		queue_free()
	elif  false and (event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact")) and $Margin/VBox/Responses/RichTextLabel1 == get_focus_owner():
		Singleton.dialogue_ui.continue(dialogue.responses[1].next_id)
		queue_free()


func _on_DialogueLabel_finished():
	if  dialogue.responses.size() == 0:
		Singleton.dialogue_ui.continue( label.dialogue.next_id)
		queue_free()


func _on_Timer_timeout():
	can_speak = true
