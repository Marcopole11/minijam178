extends StaticBody2D

@export var interactor_Area:Area2D

@export_category("stats")
@export_group("needs") #all var related to needs of the monster
@export var max_need:float = 100
@export var need_increase:float = 10
@export var need_decrease:float = 1
@export var need:float = 0
@export var need_bar:TextureProgressBar

@export_group("rage") #all var related to the rage of the monster
@export var max_rage:float = 100
@export var rage_increase:float = 1
@export var rage:float = 0
@export var rage_bar:TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	else:
		rage += rage_increase
