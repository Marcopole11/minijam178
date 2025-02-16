extends Node


var dificulty:float = 1
var totalrage:float = 0


func _process(delta: float) -> void:
	if totalrage >= 0:
		totalrage -= 0.0005
