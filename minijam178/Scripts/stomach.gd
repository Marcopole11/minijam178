extends StaticBody2D

signal organ_failure

@export var player:CharacterBody2D

@export_category("stats")
@export_group("needs") #all var related to needs of the monster
@export var max_need:float = 100 
@export var need_decrease:float = 1

@export var sprite: Node2D
@export var stomachAnim: AnimationTree

var thanks = -1

var need:float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need_decrease = need_decrease * GlobalVariables.dificulty
	need = max_need
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(thanks>0): thanks -=1
	if(thanks==0):
		stomachAnim.set("parameters/conditions/eat", false)
		
	needHandle(delta)
	tremble()
	
func needHandle(delta: float):
	if need > 0:
		need -= need_decrease * delta
		need = max(need, 0)
		if need == 0:
			organ_failure.emit()
		
	#GlobalVariables.totalrage += 0.0005
		
func _on_interactor_area_area_entered(area):
	if area.is_in_group("punch"):
		if player.pizzasprite.visible and need < max_need:
			$StomachAcidAudio.play()
			need = max_need
			player.pizzasprite.visible = false
			stomachAnim.set("parameters/conditions/eat", true)
			thanks = 10
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
