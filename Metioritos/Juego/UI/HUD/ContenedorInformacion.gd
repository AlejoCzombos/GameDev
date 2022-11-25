class_name ContenedorInformacion
extends NinePatchRect

export var autoOcultar:bool = false setget set_autoOcultar

onready var textoContenedor:Label = $Label
onready var autoOcultarTimer:Timer = $Timer
onready var animaciones:AnimationPlayer = $AnimationPlayer

var estaActivo:bool = true setget set_estaActivo

func set_estaActivo(valor:bool) -> void:
	estaActivo = valor

func set_autoOcultar(ocultar:bool) -> void:
	autoOcultar = ocultar

func modificarTexto(texto:String) -> void:
	textoContenedor.text = texto

func mostrar() -> void:
	if estaActivo:
		$AnimationPlayer.play("Mostar")

func ocultar() -> void:
	if not estaActivo:
		animaciones.stop()
	$AnimationPlayer.play("Ocultar")

func mostrarSuavizado() -> void:
	if not estaActivo:
		return
	$AnimationPlayer.play("mostarSuavizado")
	if autoOcultar:
		autoOcultarTimer.start()

func ocultarSuavizado() -> void:
	if estaActivo:
		$AnimationPlayer.play("ocultarSuavizado")

func _on_Timer_timeout():
	ocultarSuavizado()
