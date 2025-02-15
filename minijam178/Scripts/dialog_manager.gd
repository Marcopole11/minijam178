extends Node


@onready var text_box_scene =preload("res://Scenes/goofythoughts.tscn")



var dialog_lines:Array[String] = []
var current_line_index = 0

var text_box
var text_box_position:Vector2

var is_dialog_active = false
var can_advance_line = false

var timer = 600

func _process(delta: float) -> void:
	timer -= 1
	print(is_dialog_active," ",can_advance_line)

func start_dialog(position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return
	
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box= text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false
func _on_text_box_finished_displaying():
	can_advance_line = true


	
