extends Area2D

onready var animacion = $AnimationPlayer

func _on_body_entered(body):
	aplicarPowerUp(body)
	$CollisionShape2D.set_deferred("disabled", true)
	animacion.play("Consumir")

func aplicarPowerUp(_body):
	pass
