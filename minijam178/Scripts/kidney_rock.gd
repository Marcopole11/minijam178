extends StaticBody2D

@onready var hitbox: Area2D = $Hitbox

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch"):
		queue_free()
