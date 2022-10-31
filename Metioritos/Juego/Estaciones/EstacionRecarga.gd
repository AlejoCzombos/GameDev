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
	inputRecargas(event)

func inputRecargas(event: InputEvent) -> void:
	if event.is_action("RecargarEsudo"):
		navePlayer.getEscudo().controlarEnergia(radioRecarga)
	elif event.is_action("RecargarLaser"):
		navePlayer.getLaser().controlarEnergia(radioRecarga)


func puedeRecargar(event: InputEvent) -> bool:
	var hayInput = event.is_action("RecargarEsudo") || event.is_action("RecargarLaser")
	if hayInput && playerEnZona && cantidadEnergia > 0.0:
		recargarSFX.sonido_on()
		return true
	recargarSFX.sonido_off()
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

func _on_AreaRecarga_body_exited(_body) -> void:
	playerEnZona = false

