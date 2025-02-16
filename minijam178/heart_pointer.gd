extends CanvasLayer

@export var player: Node2D
@export var node2D: Node2D

@onready var heartPointer = $HeartPointer
@onready var playing_ground_max = heartPointer.get_viewport_rect().size - heartPointer.size


func _process(delta: float) -> void:
	heartPointer.position = node2D.position - player.position + player.get_viewport_rect().size/2
	heartPointer.position.x = clamp(heartPointer.position.x, 0, playing_ground_max.x)
	heartPointer.position.y = clamp(heartPointer.position.y, 0, playing_ground_max.y)
	
