extends MarginContainer
@onready var label: Label = $MarginContainer/Label

const SPEED = 8
var dir:Vector2


const showerthoughts:Array[String] = [
	"Lamps in videogames use real electricity",
	"The brain named itself.",
	"We eat pizza from the inside out.",
	"Imagine if our hiccups were as loud as sneezes.",
	"Hmmm pizza...",
	"Mirrors don’t break, they just become smaller mirrors.",
	"The moment you were born, you were also the youngest person on Earth."
]


func _ready():
	label.text = showerthoughts[randi() % showerthoughts.size()]
	dir = Vector2.RIGHT.rotated(randf_range(0,2*PI))
func _process(delta: float) -> void:
	position += dir  * SPEED * delta
