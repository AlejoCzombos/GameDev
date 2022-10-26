extends Node2D

onready var recargarSFX:AudioStreamPlayer = $RecargandoSFX
onready var sinEnergiaSFX:AudioStreamPlayer = $SinEnergiaSFX

export var radioRecarga: float = 0.1
export var cantidadEnergia:float = 14.0

var navePlayer:Player = null
var playerEnZona: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if !puedeRecargar(event):
		return
	
	if event.is_action("RecargarEsudo"):
		navePlayer.getEscudo().controlarEnergia(radioRecarga)
	elif event.is_action("RecargarLaser"):
		navePlayer.getLaser().controlarEnergia(radioRecarga)

func puedeRecargar(event: InputEvent) -> bool:
	var hayInput = event.is_action("RecargarEsudo") || event.is_action("RecargarLaser")
	if hayInput && playerEnZona && cantidadEnergia > 0.0:
		if !recargarSFX.playing:
			recargarSFX.play()
		return true
	return false

func controlarEnergia() -> void:
	cantidadEnergia -= radioRecarga
	if cantidadEnergia <= 0.0:
		sinEnergiaSFX.play()
	print("Energia estacion: ", cantidadEnergia)

func _on_AreaColision_body_entered(body:Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body) -> void:
	playerEnZona = true
	if body is Player:
		navePlayer = body
		body.set_gravity_scale(0.1)

func _on_AreaRecarga_body_exited(body) -> void:
	playerEnZona = false
	if body is Player:
		body.set_gravity_scale(0.0)
