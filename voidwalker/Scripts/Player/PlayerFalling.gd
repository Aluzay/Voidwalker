extends State
class_name PlayerFalling

@export var player: Player
var anim_player : AnimationPlayer
const JUMP_VELOCITY = -400.0
const SPEED = 300.0

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
		
	if not player.is_using_weapon:
		anim_player.play("Falling")
	else:
		anim_player.play("FallingWithWeapon")	

func Update(delta: float):	
	if player:
		if not player.is_on_floor():
			player.velocity += player.get_gravity() * delta
			
			player.direction = Input.get_axis("Left", "Right")
			
			if player.wall_collider.is_colliding() and player.direction:
				Transitioned.emit(self, "playerwallslide")
				return
			
			if player.direction:
				player.velocity.x = player.direction * SPEED
			else:
				player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
				
			if Input.is_action_just_pressed("Dash") and player.direction and player.can_dash:
				Transitioned.emit(self, "playerdash")
			
			if Input.is_action_just_pressed("ui_accept") and player.can_double_jump:
				Transitioned.emit(self, "playerdoublejump")
		else:
			Transitioned.emit(self, "playeridle")

func Exit():
	player.can_double_jump = false
	player.attack_area.monitoring = false
	player.attack_weapon_area.monitoring = false
