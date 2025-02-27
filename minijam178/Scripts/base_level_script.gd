extends Node2D

@export var organList:Array[Node2D]
@onready var failure_camera: Camera2D = $NonPausableItems/FailureCamera
@onready var explosion: GPUParticles2D = $NonPausableItems/explosion
@onready var player: CharacterBody2D = $PausableItems/Player
@onready var audio_stream_player_2d: AudioStreamPlayer = $NonPausableItems/AudioStreamPlayer2D

func _ready() -> void:
	MusicPlayer.stream = load("res://Sounds/chill-drum-loop-6887.mp3")
	MusicPlayer.volume_db = -5.7
	MusicPlayer.play()
	
	for organ in organList:
		organ.organ_failure.connect(lose_animation.bind(organ))
		
	explosion.finished.connect(_on_explosion_finished)
		
func lose_animation(node_to_follow):
	get_tree().paused = true
	failure_camera.position = player.position
	explosion.position = node_to_follow.position
	failure_camera.enabled = true
	failure_camera.make_current()
	
	var tween = create_tween()
	tween.tween_property(failure_camera, "position", node_to_follow.position, 2).from_current()
	tween.tween_interval(0.2)
	tween.tween_callback(audio_stream_player_2d.play)
	tween.tween_property(explosion, "emitting", true, 0)
	
func _on_explosion_finished() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/lose.tscn")
