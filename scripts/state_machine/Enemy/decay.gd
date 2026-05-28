extends State

class_name Decay

@export var enemy:CharacterBody3D

func enter() -> void:
	$"../../Burn".start()

func _on_burn_timeout() -> void:
	enemy.take_damage(15)
