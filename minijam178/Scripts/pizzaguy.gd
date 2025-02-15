extends StaticBody2D

@export var timeleft_bar:TextureProgressBar
@export var pizzaGuy_sprite:Sprite2D
@export var phone:Node2D 

@onready var pizzaTimer: Timer = $pizzaTimer

signal phone_sound
signal pizza_delivered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phone.calling_pizza.connect(_on_calling_pizza)
	phone_sound.connect(phone.play_sound)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeleft_bar.value = pizzaTimer.time_left/pizzaTimer.wait_time * 100
	
func _on_calling_pizza():
	if !pizzaGuy_sprite.visible and pizzaTimer.is_stopped():
		pizzaTimer.start()
		phone_sound.emit()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and pizzaGuy_sprite.visible :
		pizzaGuy_sprite.hide()
		pizza_delivered.emit()
func _on_timer_timeout() -> void:
	pizzaGuy_sprite.show()
	
