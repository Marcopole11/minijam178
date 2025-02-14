extends Node2D


@export var call_sound:AudioStreamPlayer2D

signal calling_pizza


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player in area")
		calling_pizza.emit()

func play_sound():
	call_sound.play()
