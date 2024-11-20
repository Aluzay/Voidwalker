extends Resource

class_name PlayerData

@export var health: int = 100

func change_health(value: int) -> void:
	health += value
