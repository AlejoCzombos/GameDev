class_name SectorMeteoritos
extends Node2D


export var cantidadMeteoritos:int = 10
export var IntervaloSpawnMeteoritos:float = 1.0

var spawners:Array

func _ready():
	$Timer.wait_time = IntervaloSpawnMeteoritos
	almacenarSpawners()
	conectarSenialesDetectores()

func almacenarSpawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawnerAleatoreo() -> int:
	randomize()
	return randi() % spawners.size()

func _on_Timer_timeout()-> void:
	if cantidadMeteoritos == 0:
		$Timer.stop()
		return
	spawners[spawnerAleatoreo()].spawnearMeteorito()
	cantidadMeteoritos -= 1

func conectarSenialesDetectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")

func _on_detector_body_entered(body) -> void:
	if body is Meteorito:
		body.set_estaDentro(false)
