extends CharacterBody2D

@export var pizzaguy:StaticBody2D

@export var SPEED = 300.0


@onready var punch: Area2D = $Weapons/Punch

@onready var pizzasprite: Sprite2D = $Pizza/Sprite2D
@onready var AtkAnims:AnimationPlayer = $"AtkAnims"
@onready var AnimTree:AnimationTree = $"AnimTree"


var has_pizza:bool = false
var attacking:bool = false


func _ready() -> void:
	pizzaguy.pizza_delivered.connect(_on_pizza_delivered)
	punch.set_collision_layer_value(1,false)
	punch.set_collision_mask_value(1,false)

func _physics_process(_delta):	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if(direction.length_squared() > 1):
		direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()
	
	if velocity != Vector2.ZERO and !attacking:
		AnimTree.set("parameters/Atk/blend_position", velocity)
		AnimTree.set("parameters/Idel/blend_position", velocity)
		AnimTree.set("parameters/Walk/blend_position", velocity)
		AnimTree.get("parameters/playback").travel("Walk")
	else:
		AnimTree.get("parameters/playback").travel("Idle")
	
	if Input.is_action_just_pressed("punch") and !attacking:
		AnimTree.get("parameters/playback").start("Atk")

func startAttack():
	attacking = true
	punch.set_collision_layer_value(1,true)
	punch.set_collision_mask_value(1,true)
func endAttack():
	attacking = false
	punch.set_collision_layer_value(1,false)
	punch.set_collision_mask_value(1,false)
func _on_pizza_delivered():
	pizzasprite.visible = true
	
