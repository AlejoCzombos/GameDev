class_name BaseEnemiga
extends Node2D

export var hitpoints:float = 30.0

onready var impactoSFX: AudioStreamPlayer2D = $ImpactoSFX

var estaDestruida:bool = false

func _ready() -> void:
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
	
	Eventos.emit_signal("baseDestruida", posicionesPartes)
	queue_free()

func _on_AreaColision_body_entered(body:Node) -> void:
	if body.has_method("destruir"):
		body.destruir()
