extends StaticBody2D

@onready var anim_player : AnimationPlayer
@onready var timer : Timer
@onready var sprite : Sprite2D

var saw_speed = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player = $AnimationPlayer
	timer = $Timer
	sprite = $Sprite2D
	anim_player.play("SawBlade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if anim_player.is_playing():
		moving()

func moving():
	position.y += saw_speed

func _on_timer_timeout() -> void:
	anim_player.play("SawBlade")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "End" or body.name == "Start":
		saw_speed *= -1
		anim_player.stop()
		timer.start()
