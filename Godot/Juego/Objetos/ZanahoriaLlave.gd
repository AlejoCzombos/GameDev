extends Area2D
signal consumida()

func _on_body_entered(_body):
	DatosPlayer.restarLlaves()
	emit_signal("consumida")
	$DetectorPersonake.set_deferred("disabled", true)
	$AnimationPlayer.play("Consumir")
