extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://mundo.tscn")

func _on_btn_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/pause_menu.tscn")
	
func _on_btn_exit_pressed():
	get_tree().quit()
