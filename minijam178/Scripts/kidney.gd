extends StaticBody2D

@onready var spawner: Node2D = $Spawner
@onready var spawncd: Timer = $Spawncd
@onready var need_bar: TextureProgressBar = $need_bar
@onready var rage_bar: TextureProgressBar = $rage_bar


@export_category("stats")
@export_group("need")
@export var maxrocks:int = 5

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage:float = 0


@export var spawnrage:int = 100

const KIDNEY_ROCK = preload("res://Scenes/kidney_rock.tscn")


func _process(delta: float) -> void:
	rage_bar.value = rage
	if spawner.get_child_count() >= maxrocks and rage < 100:
		rage += rage_change
	elif rage > 0:
		rage -= rage_change
func spawnrock():
	var rock = KIDNEY_ROCK.instantiate()
	rock.position = spawner.position + Vector2(randi_range(-spawnrage,spawnrage),randi_range(-spawnrage,spawnrage))
	spawner.add_child(rock)

func _on_spawncd_timeout() -> void:
	if spawner.get_child_count() < maxrocks:
		spawnrock()
