extends StaticBody2D

@onready var anim_player : AnimationPlayer
@onready var timer : Timer
@onready var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player = $AnimationPlayer
	timer = $Timer
	sprite = $Sprite2D
	anim_player.play("SawBlade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not anim_player.is_playing():
		pass


func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(0.5, 1.0)
	print(timer.wait_time)
	if  anim_player.is_playing():
			print("Stop")
			anim_player.stop()
	else:
		anim_player.play("SawBlade")
		print("Play")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
