extends CharacterBody2D

const MAX_COYOTE_TIME = 0.2
const EXPLOSIONPARTICLE = preload("res://Scenes/explosion.tscn")

@export var pizzaguy:StaticBody2D
@export var SPEED = 300.0
@export var attacking:bool = false
@export var attack_resseteable = false

@onready var punch: Area2D = $PunchArea2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var pizzasprite: Sprite2D = $Pizza/Sprite2D
@onready var AtkAnims:AnimationPlayer = $"AtkAnims"
@onready var AnimTree:AnimationTree = $"AnimTree"

var has_pizza:bool = false
var orientation:Vector2 = Vector2.DOWN
var coyote_time_punch = 0

func _ready() -> void:
	if pizzaguy:
		pizzaguy.pizza_delivered.connect(_on_pizza_delivered)

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if(direction.length_squared() > 1):
		direction = direction.normalized()

	if not direction.is_zero_approx():
		if abs(direction.x) < abs(direction.y):
			orientation = Vector2.DOWN if direction.y > 0 else Vector2.UP
		else:
			orientation = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
	
	if attacking:
		direction *= 0 
	velocity = direction * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("punch"):
		coyote_time_punch = MAX_COYOTE_TIME
		
	if coyote_time_punch > 0 and (not attacking or attack_resseteable):
		coyote_time_punch = 0
		AnimTree.set("parameters/Attack/blend_position", orientation)
		AnimTree.set("parameters/conditions/attack", true)
		AnimTree.get("parameters/playback").start("Attack", true)
	elif coyote_time_punch > 0:
		coyote_time_punch -= _delta

	if velocity != Vector2.ZERO:
		AnimTree.set("parameters/Idle/blend_position", orientation)
		AnimTree.set("parameters/Walk/blend_position", orientation)
		AnimTree.set("parameters/conditions/moving", true)
	else:
		AnimTree.set("parameters/conditions/moving", false)

func startAttack():
	punch.set_collision_layer_value(1,true)
	punch.set_collision_mask_value(1,true)
	
func endAttack():
	punch.set_collision_layer_value(1,false)
	punch.set_collision_mask_value(1,false)
	AnimTree.set("parameters/conditions/attack", false)
	
func _on_pizza_delivered():
	pizzasprite.visible = true
