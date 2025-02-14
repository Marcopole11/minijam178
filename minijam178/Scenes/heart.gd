extends StaticBody2D

@export var interactor_Area:Area2D


@export_category("stats")
@export_group("needs")
@export var max_need:float = 100
@export var need_increase:float = 10
@export var need:float = 0
@export_group("rage")
@export var max_rage:float = 100
@export var rage_increase:float = 1
@export var rage:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
