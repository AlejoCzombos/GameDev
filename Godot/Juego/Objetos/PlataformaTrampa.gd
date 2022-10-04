extends StaticBody2D



func _on_body_entered(_body):
	$DetectorPersonaje/CollisionShape2D.set_deferred("diseabled", true)
	$AnimationPlayer.play("Caida")

func dehabilitar_colisionador():
	$CollisionPolygon2D.set_deferred("diseabled", true)
