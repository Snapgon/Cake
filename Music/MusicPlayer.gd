extends Control


onready var focus = get_node("Switch1")
var current_track = "track1"
var last_track = null
var two_tracks_back = null
var aaaa = {
	"track1": preload("res://Music/One Man Symphony - A New Day\'s Hurry (Free)/One Man Symphony - A New Day\'s Hurry (Free) - 01 A New Day Begins (General Background Music).mp3"),
	"track2" : preload("res://Music/One Man Symphony - A New Day\'s Hurry (Free)/One Man Symphony - A New Day\'s Hurry (Free) - 03 A New Farm On The Outskirts (General Background Music).mp3"),
	"track3" : preload("res://Music/One Man Symphony - A New Day\'s Hurry (Free)/One Man Symphony - A New Day\'s Hurry (Free) - 04 Undiscovered Parts Of The Town (Discovery Theme).mp3"),
	"track4" :preload("res://Music/One Man Symphony - A New Day\'s Hurry (Free)/One Man Symphony - A New Day\'s Hurry (Free) - 05 Shooting Stars, In The Sky (Night Time Fishing Theme).mp3")
	
}

func _ready():
	Singleton.music_controller = self

func _focus():
	focus._focus()

func _unfocus():
	focus._unfocus()

func _switch(new_track):
	if new_track!=current_track:
		two_tracks_back = last_track
		
		
		focus._unfocus()
		if focus == $Switch1:
			if last_track !=new_track:
				$Switch2.stream = aaaa[new_track]
			$Switch2._focus()
			$Switch2.playing = true
			focus = $Switch2
		else:
			if last_track !=new_track:
				$Switch1.stream = aaaa[new_track]
			$Switch1._focus()
			$Switch1.playing = true
			focus = $Switch1
			
		last_track = current_track
		current_track = new_track
