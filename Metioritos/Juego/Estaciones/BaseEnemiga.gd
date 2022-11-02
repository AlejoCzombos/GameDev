class_name BaseEnemiga
extends Node2D

export var hitpoints:float = 30.0
export var orbital:PackedScene = null
export var numeroOrbitales:int = 10
export var intervaloSpawn:float = 0.8

onready var impactoSFX: AudioStreamPlayer2D = $ImpactoSFX
onready var timerSpawner:Timer = $TimerSpawnerEnemigos

var estaDestruida:bool = false
var posicionSpawn:Vector2 = Vector2.ZERO

func _ready() -> void:
	timerSpawner.wait_time = intervaloSpawn
	$AnimationPlayer.play(elegirAnimacionAleatorea()) 

func elegirAnimacionAleatorea() -> String:
	randomize()
	var numAnim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indiceAnimAleatorea:int = randi() % numAnim + 1
	var listaAnimacion:Array = $AnimationPlayer.get_animation_list()
	
	return listaAnimacion[indiceAnimAleatorea]

func recibirDanio(danio:float) -> void:
	hitpoints -= danio
	
	if hitpoints <= 0 && !estaDestruida:
		estaDestruida = true
		destuir()
	
	impactoSFX.play()

func destuir() -> void:
	var posicionesPartes = [
		$Sprites/Sprite.global_position,
		$Sprites/Sprite2.global_position,
		$Sprites/Sprite3.global_position,
		$Sprites/Sprite5.global_position,
		$Sprites/Sprite6.global_position
	]
	
	Eventos.emit_signal("baseDestruida",self, posicionesPartes)
	queue_free()

func _on_AreaColision_body_entered(body:Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func spawnearOrbital() -> void:
	numeroOrbitales -= 1
	$RutaEnemigo.global_position = global_position
	var posSpawn:Vector2 = deteccionCuadrante()
	
	var new_orbital:EnemigoOrbital = orbital.instance()
	new_orbital.crear(global_position + posSpawn, self, $RutaEnemigo)
	Eventos.emit_signal("spawnOrbital", new_orbital)

func deteccionCuadrante() -> Vector2:
	var playerObjetivo:Player =  DatosJuego.get_playerActual()
	if not playerObjetivo:
		return Vector2.ZERO
	
	var dirPlayer:Vector2 = playerObjetivo.global_position - global_position
	var anguloPlayer:float = rad2deg(dirPlayer.angle())
	
	if abs(anguloPlayer) <= 45.0:
		$RutaEnemigo.rotation_degrees = 180.0
		return $PosicionesSpawn/Este.position
	elif abs(anguloPlayer) > 135.0 && abs(anguloPlayer) <= 180.0:
		$RutaEnemigo.rotation_degrees = 0.0
		return $PosicionesSpawn/Oeste.position
	elif abs(anguloPlayer) > 45.0 && abs(anguloPlayer) <= 135.0:
		if sign(anguloPlayer) > 0:
			$RutaEnemigo.rotation_degrees = 270.0
			return $PosicionesSpawn/Sur.position
		else:
			$RutaEnemigo.rotation_degrees = 90.0
			return $PosicionesSpawn/Norte.position
	
	return $PosicionesSpawn/Norte.position

func _on_VisibilityNotifier2D_screen_entered() -> void:
	$VisibilityNotifier2D.queue_free()
	posicionSpawn = deteccionCuadrante()
	spawnearOrbital()
	timerSpawner.start()


func _on_TimerSpawnerEnemigos_timeout():
	if numeroOrbitales == 0:
		timerSpawner.stop()
		return
	spawnearOrbital()
