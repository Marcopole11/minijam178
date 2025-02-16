extends CanvasLayer

@export var player: Node2D
@export var heartNode: Node2D
@export var brainNode: Node2D
@export var kidneyNode: Node2D
@export var stomachNode: Node2D

@onready var heartPointer = $HeartPointer
@onready var brainPointer = $BrainPointer
@onready var stomachPointer = $StomachPointer
@onready var kidneyPointer = $KidneyPointer
@onready var playing_ground_max = Vector2(get_viewport().get_visible_rect().size) - heartPointer.size
@onready var camera:Camera2D = get_viewport().get_camera_2d()

func _process(delta: float) -> void:
	follow_node(heartPointer, heartNode)
	follow_node(brainPointer, brainNode)
	follow_node(stomachPointer, stomachNode)
	follow_node(kidneyPointer, kidneyNode)
	
func follow_node(pointer, node):
	pointer.position = get_viewport().get_visible_rect().size / 2 + node.global_position - camera.global_position
	pointer.position.x = clamp(pointer.position.x, 0, playing_ground_max.x)
	pointer.position.y = clamp(pointer.position.y, 0, playing_ground_max.y)
