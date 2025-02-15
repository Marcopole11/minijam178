extends Node2D

@export var call_sound:AudioStreamPlayer2D
@onready var barra:ProgressBar = $LoadingScreen/VBoxContainer/ProgressBar

@onready var pizzaTimer: Timer = $pizzaTimer

@onready var BasicScreen:Control = $BasicScreen
@onready var LoadingScreen:Control = $LoadingScreen
@onready var PizzaScreen:Control = $PizzaScreen

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
	barra.value = ((pizzaTimer.wait_time - pizzaTimer.time_left )/ pizzaTimer.wait_time) * 100

func _on_pizza_timer_timeout():
	LoadingScreen.hide()
	PizzaScreen.show()
	calling_pizza.emit()

func pizza_taken():
	PizzaScreen.hide()
	BasicScreen.show()
