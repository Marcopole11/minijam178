extends Node2D


@onready var pizzaTimer: Timer = $pizzaTimer

@onready var BasicScreen:Control = $Icon/BasicScreen
@onready var LoadingScreen:Control = $Icon/LoadingScreen
@onready var LoadingScreenBarra:ProgressBar = $Icon/LoadingScreen/VBoxContainer/ProgressBar
@onready var PizzaScreen:Control = $Icon/PizzaScreen
@onready var call_sound:AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var whole_sprite = $Icon

signal calling_pizza

func _ready():
	BasicScreen.show()

func _on_area_2d_area_entered(area):
	if area.is_in_group("punch") and BasicScreen.visible:
		call_sound.play()
		BasicScreen.hide()
		LoadingScreen.show()
		pizzaTimer.start()
		
func _process(_delta):
	if not pizzaTimer.is_stopped():
		LoadingScreenBarra.value = ((pizzaTimer.wait_time - pizzaTimer.time_left )/ pizzaTimer.wait_time) * 100
		whole_sprite.position = Vector2.RIGHT.rotated(randf() * 2 * PI) * 0.5

func _on_pizza_timer_timeout():
	whole_sprite.position = Vector2.ZERO
	LoadingScreen.hide()
	PizzaScreen.show()
	calling_pizza.emit()

func pizza_taken():
	PizzaScreen.hide()
	BasicScreen.show()
