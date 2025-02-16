extends StaticBody2D

@export_category("stats")
@export_group("needs") #all var related to needs of the monster
@export var max_need:float = 100
@export var need_increase:float = 10
@export var need_decrease:float = 1
@export var need:float = 0

@onready var sprite: Sprite2D = $Icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need_decrease = need_decrease * GlobalVariables.dificulty
	need = max_need

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	needHandle(delta)
	tremble()
	
func needHandle(delta:float):
	if need > 0:
		need -= need_decrease * delta
		#GlobalVariables.totalrage += 0.0005 * delta

func _on_interactor_area_area_entered(area: Area2D) -> void:
	$CrunchyPunchPlayer.play()
	if area.is_in_group("punch") and need < max_need:
		need += need_increase
		need = min(max_need, need)
		
func tremble():
	var tremble_meter = 1 - min(need/max_need, 0.85) / 0.85
	if tremble_meter > 0:
		sprite.position = Vector2.RIGHT.rotated(randf()*2*PI) * tremble_meter * 4
		sprite.modulate = lerp(Color.WHITE, Color.RED, tremble_meter)
	else:
		sprite.modulate = Color.WHITE
		sprite.position = Vector2.ZERO
