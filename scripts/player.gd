extends CharacterBody3D

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var camera_pivot: Node3D = $Camera_pivot


@export var speed: float = 5.0
@export var cam_offset: float = 2.5
@export var inv: Inv

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction: Vector3 = (camera_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
	camera_pivot.position = lerp(camera_pivot.position, position + (direction * cam_offset), 0.05)

func collect(item):
	inv.insert(item)
