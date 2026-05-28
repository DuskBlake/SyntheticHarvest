extends CharacterBody3D

var objective:Node3D = null
var life:float = 100
var player:CharacterBody3D

const SPEED:float = 8.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	$MeshInstance3D.mesh.material.albedo_color = Color(1.0, 0.447, 0.341, 1.0)

func _physics_process(delta: float) -> void:
	if player:
		# Calculate direction from enemy to player
		var direction = player.global_position - global_position
		direction = direction.normalized()
		
		# Set velocity
		velocity = direction * SPEED
		
		# Move and handle collisions
		move_and_slide()

func _process(delta: float) -> void:
	if life <= 0:
		queue_free()

func take_damage(damage:float) -> void:
	life -= damage
	$MeshInstance3D.mesh.material.albedo_color = Color(1.0, 1.0, 1.0, 1.0)
	$Timer.start()

func _on_timer_timeout() -> void:
	$MeshInstance3D.mesh.material.albedo_color = Color(1.0, 0.447, 0.341, 1.0)
