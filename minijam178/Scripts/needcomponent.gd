extends Node2D
class_name NeedComponent

@export var interaction_area:Area2D

@export var max_need:float = 15.0
var need:float
var rage:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need = max_need

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func need_rate(rate):
	if need > 0:
		need -= rate
	else:
		rage += 0.1
