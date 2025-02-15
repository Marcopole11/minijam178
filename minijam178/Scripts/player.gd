extends CharacterBody2D

@export var SPEED = 300.0
@onready var AtkAnims = $"AtkAnims"
@onready var AnimTree = $"AnimTree"

var attacking = false


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

func endAttack():
	attacking = false
