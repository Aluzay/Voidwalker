extends State
class_name PlayerWalk

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
	
		if player.direction:
			player.velocity.x = player.direction * SPEED
			anim_player.play("Walk")
		else:
			Transitioned.emit(self, "playeridle")
			
		if Input.is_action_just_pressed("Dash") and player.direction and player.can_dash:
			Transitioned.emit(self, "playerdash")
			
		if Input.is_action_just_pressed("ui_accept") and player.can_jump:
			Transitioned.emit(self, "playerjump")

func Physics_Update(_delta: float):
	pass
		
