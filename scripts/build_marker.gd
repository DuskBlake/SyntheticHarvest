extends Marker3D

@export var grid_snap: float = 0.25

var space_state: PhysicsDirectSpaceState3D
var mouse_pos: Vector2
var camera: Node3D
var ray_origin: Vector3
var ray_end: Vector3
var ray_array: Dictionary

var x_pos: float
var z_pos: float
var grid_pos: Vector3

func cursor_raycast() -> Vector3:
	space_state = get_world_3d().direct_space_state
	mouse_pos = get_viewport().get_mouse_position()
	camera = get_viewport().get_camera_3d()
	ray_origin = camera.project_ray_origin(mouse_pos)
	ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	ray_array = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(ray_origin, ray_end))
	if ray_array.has("position"):
		return ray_array["position"]
	return Vector3.ZERO

func snap_to_grid(pos: Vector3) -> Vector3:
	x_pos = round(pos.x / grid_snap) * grid_snap
	z_pos = round(pos.z / grid_snap) * grid_snap
	grid_pos = Vector3(x_pos, 0.0, z_pos)
	return grid_pos

func _process(delta: float) -> void:
	position = snap_to_grid(cursor_raycast())
