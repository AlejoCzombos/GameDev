class_name EnemigoBase
extends Nave

var playerObjetivo:Player = null
var dirPlayer:Vector2
var frameActual:int = 0

func _ready() ->void:
	playerObjetivo = DatosJuego.get_playerActual()
	Eventos.connect("naveDestruida", self, "_on_naveDestruida")

func _physics_process(_delta:float) -> void:
	frameActual += 1
	if frameActual % 3 == 0:
		rotarHaciaPlayer()

func _on_body_entered(body):
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()

func _on_naveDestruida(nave:Nave, _position, _explosiones) -> void:
	if nave is Player:
		playerObjetivo = null

func rotarHaciaPlayer():
	if playerObjetivo:
		dirPlayer = playerObjetivo.global_position - global_position
		rotation = dirPlayer.angle()

func senialDestruccion() -> void:
	Eventos.emit_signal("enemigoDestruido",self, global_position)
