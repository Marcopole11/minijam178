extends StaticBody2D


const QUESTIONTHOUGHTS = preload("res://Scenes/brainthoughts.tscn")
const GOOFYTHOUGHTS = preload("res://Scenes/goofythoughts.tscn")

signal organ_failure

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 4
@export var rage_decrease: float = 10
@export var rage_on_failure:float = 20
@export_group("questions param")
@export var min_time_popup_question = 10
@export var max_time_popup_question = 20

@onready var brain_timer: Timer = $brainTimer
@onready var question_spawner: Node2D = $QuestionSpawner
@onready var thought_spawner: Node2D = $ThoughtSpawner
@onready var sprite:Sprite2D = $Icon
@onready var cloud_punch_audio: AudioStreamPlayer2D = $CloudPunchAudio

var spawnrange:int = 60
var rage:float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if question_spawner.get_child_count() != 0 and rage <= 100:
		rage += rage_change * delta
		rage = min(rage, max_rage)
		if rage == max_rage:
			organ_failure.emit()
	elif rage >= 0:
		rage -= rage_decrease * delta
	if rage >= 100 and GlobalVariables.totalrage < 1:
		GlobalVariables.totalrage += 0.0005
	tremble()
	
func spawnquestion():
	var question = QUESTIONTHOUGHTS.instantiate()
	question.solved.connect(func ():
		brain_timer.start(randf_range(min_time_popup_question, max_time_popup_question))
		cloud_punch_audio.play()
	)
	question.wrong.connect(func ():
		rage += rage_on_failure
		cloud_punch_audio.play()
	)
	question.position = Vector2(0,0)
	question_spawner.add_child(question)
	
func spawnthoughts():
	var thought = GOOFYTHOUGHTS.instantiate()
	thought.position = thought_spawner.position
	thought_spawner.add_child(thought)

func _on_brain_timer_timeout() -> void:
	if question_spawner.get_child_count() <= 0:
		spawnquestion()

func _on_nextthought_timeout() -> void:
	if question_spawner.get_child_count() <= 1:
		spawnthoughts()

func tremble():
	var tremble_meter = max(rage/max_rage - 0.15, 0) / 0.85
	if tremble_meter > 0:
		sprite.position = Vector2.RIGHT.rotated(randf()*2*PI) * tremble_meter * 4
		sprite.modulate = lerp(Color.WHITE, Color.RED, tremble_meter)
	else:
		sprite.modulate = Color.WHITE
		sprite.position = Vector2.ZERO
