extends StaticBody2D

@export var phone:Node2D 
@export var pizzaGuy_sprite:Sprite2D
@onready var hitbox: Area2D = $Area2D


signal pizza_delivered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phone.calling_pizza.connect(_on_calling_pizza)
	pizza_delivered.connect(phone.pizza_taken)

func _on_calling_pizza():
	if !pizzaGuy_sprite.visible:
		pizzaGuy_sprite.texture = load("res://textures/props/PizzaMan.png")
		pizzaGuy_sprite.show()

func _on_area_2d_area_entered(area):
	if area.is_in_group("punch") and pizzaGuy_sprite.visible :
		pizzaGuy_sprite.texture = load("res://textures/props/PizzaManHit.png")
		pizza_delivered.emit()
		await get_tree().create_timer(1.2).timeout
		pizzaGuy_sprite.hide()
