extends State
class_name PlayerWalk

@export var player: Player
var anim_player : AnimationPlayer
const SPEED = 300.0

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()

func Update(delta: float):
	if player:
		if not player.is_on_floor() and not player.stair_collider.is_colliding() and not player.stair_collider2.is_colliding():
			Transitioned.emit(self, "playerfalling")
			return
			
		player.direction = Input.get_axis("Left", "Right")
		
		if player.direction:
			player.velocity.x = player.direction * SPEED
			if not player.is_using_weapon:
				anim_player.play("Walk")
			else:
				anim_player.play("WalkWithWeapon")
		else:
			Transitioned.emit(self, "playeridle")
			
		if Input.is_action_just_pressed("Dash") and player.direction and player.can_dash:
			Transitioned.emit(self, "playerdash")
			
		if Input.is_action_just_pressed("ui_accept"):
			Transitioned.emit(self, "playerjump")	

func Exit() -> void:
	player.attack_area.monitoring = false
	player.attack_weapon_area.monitoring = false
