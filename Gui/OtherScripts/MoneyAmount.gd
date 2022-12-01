extends ColorRect

export var money_amount = 0



func _ready():
	Singleton.money_ui = self 


func _process(delta):
	$RichTextLabel.bbcode_text = "[right]"+str(money_amount)+"[/right]"


func update_money(new_money):
	var new_tween = get_tree().create_tween()
	$RichTextLabel.modulate = Color("ef8354")
	new_tween.tween_property(self, "money_amount", new_money, 0.3).set_trans(Tween.TRANS_CIRC)
	new_tween.tween_property($RichTextLabel, "modulate", Color("ffffff"), 0.3).set_trans(Tween.TRANS_CIRC)
	$AudioStreamPlayer._play()
