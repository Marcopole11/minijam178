extends StaticBody2D

const KIDNEY_ROCK = preload("res://Scenes/kidney_rock.tscn")

signal organ_failure

@export_category("stats")
@export_group("need")
@export var maxrocks:int = 5

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage_decrease_rate:  float = 10
@export var spawnrage:int = 100

@onready var spawner: Node2D = $Spawner
@onready var spawncd: Timer = $Spawncd
@onready var sprite: Sprite2D = $Icon

var rage:float = 0

func _ready() -> void:
	spawncd.wait_time = spawncd.wait_time / GlobalVariables.dificulty

func _process(delta: float) -> void:
	if spawner.get_child_count() > 0 and rage < 100:
		rage += rage_change * delta * spawner.get_child_count()
		rage = min(rage, max_rage)
		if rage == max_rage:
			organ_failure.emit()
	elif rage > 0:
		rage -= rage_change * delta * rage_decrease_rate
		rage = max(rage, 0)
	if rage >= 100 and GlobalVariables.totalrage < 1:
		GlobalVariables.totalrage += 0.0005
	tremble()
		
func spawnrock():
	var rock = KIDNEY_ROCK.instantiate()
	rock.position = spawner.position + Vector2(randi_range(-spawnrage,spawnrage),randi_range(-spawnrage,spawnrage))
	rock.rotation = deg_to_rad(randi_range(0,359))
	spawner.add_child(rock)

func _on_spawncd_timeout() -> void:
	if spawner.get_child_count() < maxrocks:
		spawnrock()
		
func tremble():
	var tremble_meter = max(rage/max_rage - 0.15, 0) / 0.85
	if tremble_meter > 0:
		sprite.position = Vector2.RIGHT.rotated(randf()*2*PI) * tremble_meter * 4
		sprite.modulate = lerp(Color.WHITE, Color.RED, tremble_meter)
	else:
		sprite.modulate = Color.WHITE
		sprite.position = Vector2.ZERO
