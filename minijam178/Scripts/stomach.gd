extends StaticBody2D

@export var player:CharacterBody2D

@export_category("stats")
@export_group("needs") #all var related to needs of the monster
@export var max_need:float = 100 
@export var need_increase:float = 10
@export var need_decrease:float = 1
@export var need:float = 0

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_change:float = 1
@export var rage:float = 0

@onready var sprite: Sprite2D = $Icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need_decrease = need_decrease * GlobalVariables.dificulty
	need = max_need
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	needHandle(delta)
	tremble()
	
func needHandle(delta: float):
	if need > 0:
		need -= need_decrease * delta
		if rage > 0:
			rage -= rage_change * delta
	elif rage < max_rage:
		rage += rage_change * delta
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

func tremble():
	var tremble_meter = 1 - min(need/max_need, 0.85) / 0.85
	if tremble_meter > 0:
		sprite.position = Vector2.RIGHT.rotated(randf()*2*PI) * tremble_meter * 4
		sprite.modulate = lerp(Color.WHITE, Color.RED, tremble_meter)
	else:
		sprite.modulate = Color.WHITE
		sprite.position = Vector2.ZERO
