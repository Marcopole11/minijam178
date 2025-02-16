extends Control

@export var background:TextureRect;
@export var fotito:Node;
@export var fotitoMove:float;
@export var fotitoPunchMove:float;

var sBack:ShaderMaterial
var sSize:float
var fMC:TextureRect
var fPunch:TextureRect
var fMCK:Vector3
var fPunchK:Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	sBack = background.material;
	sSize = sBack.get_shader_parameter("cordX")
	fMC = fotito.get_node("Fotito")
	fPunch = fotito.get_node("Punch")
	fMCK = Vector3(fMC.position.x,fMC.position.y,fMC.rotation)
	fPunchK = Vector3(fPunch.position.x,fPunch.position.y,fPunch.rotation)

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
	get_tree().change_scene_to_file("res://mundo.tscn")

func _on_btn_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/pause_menu.tscn")
	
func _on_btn_exit_pressed():
	get_tree().quit()
