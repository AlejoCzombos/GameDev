class_name meteoritosSpawner
extends Position2D

export var direccion:Vector2 = Vector2(1,1)
export var rangoTamanioMeteoritos: Vector2 = Vector2(0.6, 2.5)

func _ready() -> void:
	yield(owner, "ready")
	spawnearMeteorito()

func spawnearMeteorito() -> void:
	Eventos.emit_signal("crearMeteorito", global_position, direccion, tamanioMeteoritoAleatorio())

func tamanioMeteoritoAleatorio() -> float:
	randomize()
	return rand_range(rangoTamanioMeteoritos[0], rangoTamanioMeteoritos[1])
