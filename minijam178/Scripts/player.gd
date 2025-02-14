extends CharacterBody2D

@export var speed := 150.0
@export var sprint_multiplier := 1.5
@export var jump_force := 250.0
@export var gravity := 500.0

var velocity_y := 0.0  # Velocidad vertical (para el salto)
var is_grounded := true

func _physics_process(delta):
	var direction := Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()

	var current_speed = speed
	if Input.is_action_pressed("ui_shift"):
		current_speed *= sprint_multiplier

	velocity.x = direction.x * current_speed
	velocity.y = direction.y * current_speed

	# Manejo del salto
	if is_grounded and Input.is_action_just_pressed("ui_accept"):
		velocity_y = -jump_force
		is_grounded = false

	# Aplicar gravedad
	if not is_grounded:
		velocity_y += gravity * delta

	# Detectar si aterriza
	if position.y >= 0:  # Suelo en Y = 0
		position.y = 0
		velocity_y = 0
		is_grounded = true

	move_and_slide()
