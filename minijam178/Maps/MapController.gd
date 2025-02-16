extends Node2D

@onready var failure_camera: Camera2D = $FailureCamera
@onready var kidney: StaticBody2D = $Kidney
@onready var brain: StaticBody2D = $Brain
@onready var heart: StaticBody2D = $Heart
@onready var stomach: StaticBody2D = $Stomach
@onready var player: CharacterBody2D = $Player
@onready var pointer_ui: CanvasLayer = $PointerUi
@onready var explosion: GPUParticles2D = $explosion

func _ready():
	MusicPlayer.stream = load("res://Sounds/chill-drum-loop-6887.mp3")
	MusicPlayer.volume_db = -5.7
	MusicPlayer.play()

func _on_kidney_organ_failure() -> void:
	lose_animation(kidney)

func _on_brain_organ_failure() -> void:
	lose_animation(brain)

func _on_heart_organ_failure() -> void:
	lose_animation(heart)

func _on_stomach_organ_failure() -> void:
	lose_animation(stomach)

func lose_animation(node_to_follow):
	get_tree().paused = true
	pointer_ui.visible = false
	failure_camera.position = player.position
	explosion.position = node_to_follow.position
	failure_camera.enabled = true
	failure_camera.make_current()
	
	var tween = create_tween()
	tween.tween_property(failure_camera, "position", node_to_follow.position, 2).from_current()
	tween.tween_interval(0.2)
	tween.tween_callback($AudioStreamPlayer2D.play)
	tween.tween_property(explosion, "emitting", true, 0)
	

func _on_explosion_finished() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/lose.tscn")
