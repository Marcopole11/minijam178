extends CanvasLayer

@export var win_time = 180
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var win_timer: Timer = $WinTimer
@onready var time_label: Label = $ProgressBar/CenterContainer/HBoxContainer/TimeLabel


func _ready() -> void:
	win_timer.wait_time = win_time
	win_timer.start()

func _on_win_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/win.tscn")
	
func _process(delta: float) -> void:
	progress_bar.value = win_timer.time_left / win_timer.wait_time * 100.0
	var mins:int = floori(win_timer.time_left / 60)
	var secs:int = floori(fmod(win_timer.time_left, 60))
	time_label.text = "%0*d:%0*d"%[2, mins, 2, secs]
