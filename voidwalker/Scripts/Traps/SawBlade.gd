extends StaticBody2D

@onready var anim_player : AnimationPlayer
@onready var timer : Timer
@onready var sprite : Sprite2D
@export var saw_speed = 0.02

var damage = 20

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
	timer.stop()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "End" or body.name == "Start":
		saw_speed *= -1
		anim_player.stop()
		timer.start()
	
	elif body.name == "Player" and anim_player.is_playing():
		damage = 100
		print("PlAYER")
		applyDamage(body, damage)		
	
	elif body.name == "Player" and !anim_player.is_playing():
		damage = 20
		applyDamage(body, damage)
	
func applyDamage(player: Player, damage: int):
	for child in player.get_children():
		if child is Damageable:
			var direciton_to_damageable = (player.global_position - global_position)
			var direction_sign = sign(direciton_to_damageable.x)
			
			if direction_sign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)	
