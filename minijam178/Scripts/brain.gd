extends StaticBody2D
@onready var brain_timer: Timer = $brainTimer
@onready var question_spawner: Node2D = $QuestionSpawner
@onready var rage_bar: TextureProgressBar = $rage_bar
@onready var thought_spawner: Node2D = $ThoughtSpawner


const QUESTIONTHOUGHTS = preload("res://Scenes/brainthoughts.tscn")
const GOOFYTHOUGHTS = preload("res://Scenes/goofythoughts.tscn")
@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage:float = 0

var spawnrange:int = 60


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rage_bar.value = rage
	
	if question_spawner.get_child_count() != 0 and rage <= 100:
		rage += rage_change
	elif rage >= 0:
		rage -= rage_change
	if rage >= 100 and GlobalVariables.totalrage < 100:
		GlobalVariables.totalrage += 0.01
func spawnquestion():
	var question = QUESTIONTHOUGHTS.instantiate()
	question.position = Vector2(0,0)
	question_spawner.add_child(question)
func spawnthoughts():
	var thought = GOOFYTHOUGHTS.instantiate()
	thought.position = thought_spawner.position + Vector2(randi_range(-spawnrange,spawnrange),randi_range(-spawnrange,spawnrange))
	thought_spawner.add_child(thought)

func _on_brain_timer_timeout() -> void:
	if question_spawner.get_child_count() <= 0:
		spawnquestion()
		print("question spawned")


func _on_nextthought_timeout() -> void:
	if question_spawner.get_child_count() <= 1:
		spawnthoughts()
