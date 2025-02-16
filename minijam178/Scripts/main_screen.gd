extends Control

@export var background:TextureRect;
@export var fotito:Node;
@export var fotitoMove:float;
@export var fotitoPunchMove:float;

@onready var btn_play: Button = $VBoxContainer/BTN_Play

var sBack:ShaderMaterial
var sSize:float
var fMC:TextureRect
var fPunch:TextureRect
var fMCK:Vector3
var fPunchK:Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	var music_res = load("res://Sounds/4-9-18 idk.mp3 2019.mp3")
	if not MusicPlayer.stream or MusicPlayer.stream.resource_path != music_res.resource_path:
		MusicPlayer.stream = music_res
		MusicPlayer.volume_db = -5.7
		MusicPlayer.play()
	sBack = background.material;
	sSize = sBack.get_shader_parameter("cordX")
	fMC = fotito.get_node("Fotito")
	fPunch = fotito.get_node("Punch")
	fMCK = Vector3(fMC.position.x,fMC.position.y,fMC.rotation)
	fPunchK = Vector3(fPunch.position.x,fPunch.position.y,fPunch.rotation)
	btn_play.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var moved = Vector2(
		zeroToOne(get_viewport().get_mouse_position().x/get_viewport().get_visible_rect().size.x),
		zeroToOne(get_viewport().get_mouse_position().y/get_viewport().get_visible_rect().size.y))
	sBack.set_shader_parameter("cordX",moved.x*sSize)
	sBack.set_shader_parameter("cordY",moved.y*sSize)
	fMC.position = Vector2((moved.x*fotitoMove)+fMCK.x,(moved.y*fotitoMove)+fMCK.y)
	fPunch.position = Vector2((moved.x*fotitoPunchMove)+fPunchK.x,(moved.y*fotitoPunchMove)+fPunchK.y)
	pass

func zeroToOne(num:float):
	if num < 0:
		return 0
	if num > 1:
		return 1
	return num

func _on_btn_play_pressed():
	get_tree().change_scene_to_file("res://Maps/tiled_map.tscn")

func _on_btn_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/config_screen.tscn")
	
func _on_btn_exit_pressed():
	get_tree().quit()

func _on_btn_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://tutorial/Tutorial.tscn")
