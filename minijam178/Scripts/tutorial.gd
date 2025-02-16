extends Control

@onready var panel_container: PanelContainer = $VBoxContainer/PanelContainer
@onready var back_button: Button = $VBoxContainer/MarginContainer/HBoxContainer/BackButton
@onready var next_button: Button = $VBoxContainer/MarginContainer/HBoxContainer/NextButton

var index = 0

func _ready() -> void:
	back_button.disabled = index == 0
	next_button.disabled = index == panel_container.get_child_count() - 1
	next_button.grab_focus()

func _on_back_button_pressed() -> void:
	panel_container.get_child(index).visible = false
	index -= 1
	panel_container.get_child(index).visible = true
	
	back_button.disabled = index == 0
	next_button.disabled = index == panel_container.get_child_count() - 1

func _on_next_button_pressed() -> void:
	panel_container.get_child(index).visible = false
	index += 1
	panel_container.get_child(index).visible = true

	back_button.disabled = index == 0
	next_button.disabled = index == panel_container.get_child_count() - 1

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainScreen.tscn")
