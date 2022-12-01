extends Spatial

var interactables = []
var focus = null

var can_interact= false
var interaction_

var previous = false

func _process(delta):
	if $RayCast.is_colliding():
		if $RayCast.is_colliding():
			if $RayCast.get_collider() != focus:
				if  $RayCast.get_collider().is_in_group("Interactable") and $RayCast.get_collider() .interactable and interactables.has($RayCast.get_collider()):
					if focus == null:
						$RayCast.get_collider().in_focus = true
						focus = $RayCast.get_collider() 
					else:
						focus.in_focus = false
						$RayCast.get_collider().in_focus = true
						focus = $RayCast.get_collider() 
	else:
		if interactables.size() != 0:
			var lowest_distance = get_parent().global_translation.distance_to(interactables[0].global_translation)
			var lowest = interactables[0]
			for i in interactables:
				if  get_parent().global_translation.distance_to(i.global_translation)<lowest_distance:
					lowest_distance =  get_parent().global_translation.distance_to(i.global_translation)
					lowest = i
			if focus == null:
				lowest.in_focus = true
				focus = lowest
			else:
				focus.in_focus = false
				lowest.in_focus = true
				focus = lowest
	if Input.is_action_just_pressed("Interact") and focus!=null:
		focus.Interact()
		can_interact = false
	
	if !Singleton.interact_thing.hidden and focus==null:
		
		Singleton.interact_thing.hide()
	elif Singleton.interact_thing.hidden and focus!=null:
		
		Singleton.interact_thing.reveal()
	previous = can_interact
	

func _on_Area_body_entered(body):
	if body.is_in_group("Interactable") and body.interactable:
		
		interactables.append(body)
		if focus == null:
			body.in_focus = true
			focus = body

func _on_Area_body_exited(body):
	if interactables.has(body) == true:
		interactables.erase(body)
		if body.in_focus:
			focus = null
			body.in_focus = false


func _on_Timer_timeout():
	can_interact = true
