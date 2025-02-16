extends Node2D
const EXPLOSIONPARTICLE = preload("res://Scenes/explosion.tscn")


func spawnparticle():
	var explosion = EXPLOSIONPARTICLE.instantiate()
	explosion.position = global_position + Vector2(randi_range(-100,100),randi_range(-100,100))
	explosion.emitting = true
	get_tree().current_scene.add_child(explosion)
	
	queue_free()
	
func _process(delta: float) -> void:
	if GlobalVariables.totalrage >= 0.6:
		spawnparticle()
