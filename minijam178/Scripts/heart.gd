extends StaticBody2D



@onready var need_bar: TextureProgressBar = $need_bar
@onready var rage_bar: TextureProgressBar = $rage_bar



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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	need = max_need

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	need_bar.value = need
	rage_bar.value = rage
	needHandle()
	
func needHandle():
	if need > 0:
		need -= need_decrease
		if rage > 0:
			rage -= rage_change
	elif rage < max_rage:
		rage += rage_change


func _on_interactor_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch") and need < max_need:
		need += need_increase
		
