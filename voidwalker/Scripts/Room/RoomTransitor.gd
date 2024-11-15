extends Node

var camera : Camera2D
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_room(room_position: Vector2, room_size: Vector2, area: Area2D) -> void:
	if not player and not camera:
		player = get_tree().current_scene.get_node("Player")
		camera = get_tree().current_scene.get_node("Camera2D")
		
	camera.current_room_center = room_position
	camera.current_room_size = room_size
	camera.current_area = area
