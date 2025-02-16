extends Control

func _on_button_quit_pressed() -> void:
	get_tree().quit()

func _on_go_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mainScreen.tscn")
