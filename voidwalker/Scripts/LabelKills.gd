extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Global.player.enemies_killed) + "/" + str(Global.nbr_enemies) 
	Global.connect("enemy_killed", update_label)

func update_label() -> void:
	text = str(Global.player.enemies_killed) + "/" + str(Global.nbr_enemies) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
