extends Camera2D

@onready var player: Player = get_parent()

func _ready() -> void:
	limit_bottom = player.global_position.y + 200
	limit_right = player.global_position.x + 100
	print(limit_bottom)

func _process(delta: float) -> void:
	pass
	
