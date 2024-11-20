extends State
class_name PlayerAttack

@export var player: Player
var anim_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func Enter():
	if not anim_player:
		if player:
			anim_player = player.get_animation_player()
			
	if not player.is_using_weapon:
		anim_player.play("Attack")
	else:
		anim_player.play("AttackWithWeapon")
			
func Update(delta: float):
	if player.direction:
		Transitioned.emit(self, "playerwalk")
	
	if not player.is_on_floor():
		Transitioned.emit(self, "playerfalling")
	
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		Transitioned.emit(self, "playerjump")
	
	if not anim_player.is_playing():
		Transitioned.emit(self, "playeridle")
