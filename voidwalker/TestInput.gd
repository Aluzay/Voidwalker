extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Blur")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showAskName() -> void:
	print("Show Ask Name")
	visible = true
	$AnimationPlayer.play("Blur")
