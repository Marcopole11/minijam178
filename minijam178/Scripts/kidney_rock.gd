extends StaticBody2D

@onready var hitbox: Area2D = $Hitbox

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch"):
		$CrunchyPunchPlayer.play(0.2)
		hide()
		call_deferred("disable_kidney_stone")
		await $CrunchyPunchPlayer.finished
		queue_free()

func disable_kidney_stone():
	if is_instance_valid(self):
		$CollisionPolygon2D.disabled = true
		$Hitbox/CollisionPolygon2D.disabled = true
