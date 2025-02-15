extends Node2D


@export var call_sound:AudioStreamPlayer2D

signal calling_pizza

func play_sound():
	call_sound.play()

func _on_area_2d_area_entered(area):
	if area.is_in_group("punch"):
		calling_pizza.emit()
