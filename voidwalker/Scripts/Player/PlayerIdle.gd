extends State
class_name PlayerIdle

@export var player: Player
var anim_player : AnimationPlayer
const SPEED = 300.0

func Update(delta: float):
	if not anim_player:
		anim_player = player.get_animation_player()
	
	switch_weapon()
	
	if player:
		if not player.is_on_floor():
			Transitioned.emit(self, "playerfalling")
		
		player.direction = Input.get_axis("Left", "Right")
		
		if player.direction == 0:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
			if not player.is_using_weapon:
				anim_player.play("Idle")
			else:
				anim_player.play("IdleWithWeapon")
		else:
			Transitioned.emit(self, "playerwalk")
		
		if Input.is_action_just_pressed("Attack") and player.is_on_floor():
			Transitioned.emit(self, "playerattack")
		
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "playerjump")

func Exit() -> void:
	player.attack_area.monitoring = false
	player.attack_weapon_area.monitoring = false

func switch_weapon() -> void:
	if Input.is_action_just_pressed("Switch"):
		player.is_using_weapon = !player.is_using_weapon
