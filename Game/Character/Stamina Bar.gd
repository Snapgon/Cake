extends TextureProgress

func _ready():
	Singleton.stamina = self


var no_fade = false

onready var aaa = null
func _process(delta):
	max_value =100.0
	value = clamp(Singleton.player.current_stamina*12.5, 0 ,100)
	$"Stamina Bar2".value = clamp(Singleton.player.current_stamina*12.5-100, 0 ,100)
	if Singleton.player.current_stamina*12.5 == Singleton.player.max_stamina*12.5 and aaa == null and !no_fade:
		aaa = get_tree().create_tween()
		aaa.tween_property(self, "modulate", Color("00ffffff"), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	elif modulate !=Color( "ffffff" )and (Singleton.player.current_stamina*12.5 < Singleton.player.max_stamina*12.5 ):
		aaa.kill()
		aaa = null
		modulate = Color("ffffff" )

func change():
	value = Singleton.player.current_stamina*12.5
	if aaa !=null:
		aaa.kill()
		aaa = null
	modulate = Color("ffffff" )
	tint_progress = Color("ffffff")
	$"Stamina Bar2".tint_progress = Color("ffffff")
	var aa = get_tree().create_tween()
	aa.tween_property(self,"tint_progress",Color("84ff92"), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	var aaaa = get_tree().create_tween()
	aaaa.tween_property(get_node("Stamina Bar2"),"tint_progress",Color("84ff92"), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	no_fade = true
	$Timer.start()
	


func _on_Timer_timeout():
	
	no_fade = false
