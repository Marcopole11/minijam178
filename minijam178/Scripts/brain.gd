extends StaticBody2D
@onready var brain_timer: Timer = $brainTimer
@onready var thought_spawner: Node2D = $thoughtSpawner
@onready var rage_bar: TextureProgressBar = $rage_bar


const BRAINTHOUGHTS = preload("res://Scenes/brainthoughts.tscn")



@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage:float = 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rage_bar.value = rage
	
	if thought_spawner.get_child_count() != 0 and rage <= 100:
		rage += rage_change
	elif rage >= 0:
		rage -= rage_change

func spawnquestion():
	var question = BRAINTHOUGHTS.instantiate()
	question.position = Vector2(0,0)
	thought_spawner.add_child(question)


func _on_brain_timer_timeout() -> void:
	if thought_spawner.get_child_count() <= 0:
		spawnquestion()
		print("question spawned")
