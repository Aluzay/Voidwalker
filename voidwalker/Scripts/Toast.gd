extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.player.damageable.health < Global.player.damageable.max_health:
			print("Player health before collecting toast: " + str(Global.player.damageable.health + 10))
			if Global.player.damageable.health + 10 < 200:
				Global.player.damageable.health += 10
			else:
				Global.player.damageable.health = 200
			
			print("Player health after collecting toast: " + str(Global.player.damageable.health + 10))
			Global.emit_signal("healed", null, 0, Vector2.ZERO)
			
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		
		tween.tween_property(self, "position", position - Vector2(0, 35), 0.35)
		tween2.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
