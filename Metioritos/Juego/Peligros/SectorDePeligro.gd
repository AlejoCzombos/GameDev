class_name SectorDePeligro
extends Area2D

export(String, "vacio", "Meteorito", "Enemigo") var tipoPeligro
export var numeroPeligros:int = 10

func _on_body_entered(body) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	yield(get_tree().create_timer(0.1), "timeout")
	enviarSenial()

func enviarSenial() -> void:
	Eventos.emit_signal("naveEnSectorPeligro", $Position2D.global_position, tipoPeligro, numeroPeligros)
	queue_free()
