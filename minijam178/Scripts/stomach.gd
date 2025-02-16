extends StaticBody2D

@export var interactor_Area:Area2D
@export var player:CharacterBody2D

@export_category("stats")
@export_group("needs") #all var related to needs of the monster
@export var max_need:float = 100 
@export var need_increase:float = 10
@export var need_decrease:float = 1
@export var need:float = 0
@export var need_bar:TextureProgressBar

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage:float = 0
@export var rage_bar:TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need_decrease = need_decrease * GlobalVariables.dificulty
	need = max_need
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	need_bar.value = need
	rage_bar.value = rage
	needHandle()
		
func interact():
	need += need_increase
	
func needHandle():
	if need > 0:
		need -= need_decrease
		if rage > 0:
			rage -= rage_change
	elif rage < max_rage:
		rage += rage_change
	if rage >= 100 and GlobalVariables.totalrage < 1:
		GlobalVariables.totalrage += 0.0005
		
func _on_interactor_area_area_entered(area):
	if area.is_in_group("punch"):
		if player.pizzasprite.visible and need < max_rage:
			$StomachAcidAudio.play()
			need = need_increase
			player.pizzasprite.visible = false
		else:
			$PunchAudio.play(0.1)
