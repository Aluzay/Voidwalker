extends ParallaxBackground

# Vitesse de défilement
var scroll_speed = Vector2(20, 0)

func _process(delta) -> void:
	offset += scroll_speed * delta
