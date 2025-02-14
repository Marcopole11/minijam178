extends CharacterBody2D

@export var SPEED = 300.0
@onready var AtkAnims = $"AtkAnims"


func _physics_process(_delta):	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if(direction.length_squared() > 1):
		direction = direction.normalized()

	velocity = direction * SPEED
	
	move_and_slide()
	
	if Input.is_action_just_pressed("punch"):
		AtkAnims.play("punch_down")
