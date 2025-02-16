extends Control

func _ready():
	MusicPlayer.stream = load("res://Sounds/congratulations-deep-voice-172193.mp3")
	MusicPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainScreen.tscn")
