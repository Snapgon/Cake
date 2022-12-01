extends Sprite3D


export var amount = 5



func _on_Area_body_entered(body):
	
	var new_money = Singleton.coin.instance()
	get_parent().get_parent().add_child(new_money)
	
	new_money.global_translation = Singleton.player.global_translation
	
	Singleton.player.money +=amount
	Singleton.money_ui.update_money(Singleton.player.money )
	queue_free()
