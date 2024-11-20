extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("boss_killed", _on_boss_killed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_boss_killed() -> void:
	print("The boss have been killed")
	$EndMenu/EndMenu.showMenu()
