class_name EnemigoBase
extends Nave

func _ready() ->void:
	canion.set_estaDisparando(true)

func _on_body_entered(body):
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()

func senialDestruccion() -> void:
	Eventos.emit_signal("naveDestruida", self, global_position, 1)
