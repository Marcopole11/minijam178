extends StaticBody2D

@export var phone:Node2D 
@onready var hitbox: Area2D = $Area2D
@onready var pizzaGuyStandingSprite = $PizzaGuyStandingBody
@onready var pizzaGuyHitSprite = $PizzaGuyHitBody

signal pizza_delivered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phone.calling_pizza.connect(_on_calling_pizza)
	pizza_delivered.connect(phone.pizza_taken)

func _on_calling_pizza():
	if !pizzaGuyStandingSprite.visible:
		pizzaGuyStandingSprite.show()

func _on_area_2d_area_entered(area):
	if area.is_in_group("punch") and pizzaGuyStandingSprite.visible:
		pizzaGuyHitSprite.show()
		pizzaGuyStandingSprite.hide()
		$OofPlayer.play()
		pizza_delivered.emit()
		var tween = create_tween()
		tween.tween_property(pizzaGuyHitSprite, "position", Vector2(25, 0), 1.2).from(Vector2.ZERO)
		tween.tween_callback(pizzaGuyHitSprite.hide)
