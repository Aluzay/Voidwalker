extends Camera2D

@export var follow_smoothing: float = 0.1
@export var limit_smoothing: float = 14

var smoothing: float

var current_room_center: Vector2
var current_room_size: Vector2
var current_area: Area2D

@onready var view_size: Vector2 = get_viewport_rect().size
@onready var timer : Timer = $Timer

var zoom_view_size: Vector2

func _ready() -> void:
	smoothing = 1
	smoothing = follow_smoothing

func _physics_process(delta: float) -> void:
	zoom_view_size = view_size * zoom
	
	var target_position := calculate_target_position(current_room_center, current_room_size)
	
	position = lerp(position, target_position, smoothing)
	
	apply_limit(delta)
	
	print(limit_left)
	
func calculate_target_position(room_center: Vector2, room_size: Vector2) -> Vector2:
	var x_margin: float = (room_size.x - zoom_view_size.x) / 2
	var y_margin: float = (room_size.y - zoom_view_size.y) / 2
	
	var return_position: Vector2 = Vector2.ZERO
	
	if x_margin <= 0:
		return_position.x = room_center.x
	else:
		var left_limit: float = room_center.x - x_margin
		var right_limit: float = room_center.x + x_margin
		return_position.x = clamp(RoomTransitor.player.position.x, left_limit, right_limit)

	if y_margin <= 0:
		return_position.y = room_center.y
	else:
		var top_limit: float = room_center.y - y_margin
		var bottom_limit: float = room_center.y + y_margin
		return_position.y = clamp(RoomTransitor.player.position.y, top_limit, bottom_limit)
		
	return return_position	

func apply_limit(delta: float):
	if current_area:
		limit_bottom = lerp(limit_bottom, current_area.limit_bottom, limit_smoothing * delta)
		limit_top = lerp(limit_top, current_area.limit_top, limit_smoothing * delta)
		limit_left = lerp(limit_left, current_area.limit_left, limit_smoothing * delta)
		limit_right = lerp(limit_right, current_area.limit_right, limit_smoothing * delta)


func _on_timer_timeout() -> void:
	pass