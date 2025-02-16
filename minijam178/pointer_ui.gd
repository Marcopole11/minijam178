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
@onready var screen_center = Vector2(get_viewport().get_visible_rect().size/2)

func _process(delta: float) -> void:
	follow_node(heartPointer, heartNode)
	follow_node(brainPointer, brainNode)
	follow_node(stomachPointer, stomachNode)
	follow_node(kidneyPointer, kidneyNode)
	update_colors()
	
func follow_node(pointer:Control, node:Node2D):
	pointer.position = screen_center + node.global_position - camera.global_position
	pointer.position.x = clamp(pointer.position.x, 0, playing_ground_max.x)
	pointer.position.y = clamp(pointer.position.y, 0, playing_ground_max.y)
	
func update_colors():
	heartPointer.modulate = lerp(Color.WEB_GREEN, Color.WEB_MAROON, 1-heartNode.need/ heartNode.max_need)
	stomachPointer.modulate = lerp(Color.WEB_GREEN, Color.WEB_MAROON, 1-stomachNode.need/ stomachNode.max_need)
	kidneyPointer.modulate = lerp(Color.WEB_GREEN, Color.WEB_MAROON, kidneyNode.rage/ kidneyNode.max_rage)
	brainPointer.modulate = lerp(Color.WEB_GREEN, Color.WEB_MAROON, brainNode.rage/ brainNode.max_rage)
	
