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
	
	controlarEnergia()
	
	if event.is_action("RecargarEsudo"):
		navePlayer.getEscudo().controlarEnergia(radioRecarga)
		recargarSFX.sonido_on()
	elif event.is_action("RecargarLaser"):
		navePlayer.getLaser().controlarEnergia(radioRecarga)
		recargarSFX.sonido_on()
	if event.is_action_released("RecargarEsudo") || event.is_action_released("RecargarLaser"):
		recargarSFX.sonido_off()

func puedeRecargar(event: InputEvent) -> bool:
	var hayInput = event.is_action("RecargarEsudo") || event.is_action("RecargarLaser")
	if hayInput && playerEnZona && cantidadEnergia > 0.0:
		return true
	return false

func controlarEnergia() -> void:
	cantidadEnergia -= radioRecarga
	if cantidadEnergia <= 0.0:
		sinEnergiaSFX.play()
		recargarSFX.apagar()
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
