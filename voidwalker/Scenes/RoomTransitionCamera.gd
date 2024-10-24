extends Camera2D
class_name RoomTransitionCamera

const HORIZONTAL_OFFSET : int = 64
const VERTICAL_OFFSET : int = 54

#Target node the camera will be tracking
@export var target_node : Node2D = null

@onready var camera_horizontal_movement : int = (get_viewport_rect().size.x/1.5) - HORIZONTAL_OFFSET
@onready var camera_vertical_movement : int = (get_viewport_rect().size.y/1.5) - VERTICAL_OFFSET

var current_room : Vector2 = Vector2.ZERO

var origin_offset : Vector2 = Vector2.ZERO

func _ready() -> void:
	print(camera_horizontal_movement)
	print(camera_vertical_movement)
	
	origin_offset = target_node.get_position()
	print(origin_offset)
	set_position(origin_offset)
	
func _process(delta: float) -> void:
	pass

func _UpdateCameraPosition(direction : Vector2) -> void:
	current_room += direction
	print("---------------")
	print(Vector2(camera_horizontal_movement, camera_vertical_movement))
	print(origin_offset + current_room * Vector2(camera_horizontal_movement, camera_vertical_movement))
	print("---------------")
	
	set_position(origin_offset + current_room * Vector2(camera_horizontal_movement, camera_vertical_movement))

func _OnBodyEnteredTop(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.UP)
	print("Top")

func _OnBodyEnteredBottom(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.DOWN)

func _OnBodyEnteredLeft(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.LEFT)


func _OnBodyEnteredRight(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.RIGHT)
