extends State
class_name PlayerIdle

@export var player: Player
var anim_player : AnimationPlayer
const SPEED = 300.0

func Update(delta: float):
	if not anim_player:
		anim_player = player.get_animation_player()

	if player:
		if not player.is_on_floor():
			Transitioned.emit(self, "playerfalling")
		
		player.direction = Input.get_axis("Left", "Right")
		
		if player.direction == 0:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
			anim_player.play("Idle")
		else:
			Transitioned.emit(self, "playerwalk")
		
		if Input.is_action_just_pressed("Attack") and player.is_on_floor():
			print("Attack")
			Transitioned.emit(self, "playerattack")
		
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "playerjump")
