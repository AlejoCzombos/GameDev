class_name HUD
extends CanvasLayer

onready var infoZonaRecarga:ContenedorInformacion = $ContenedorInformacion

func _ready() -> void:
	conectarSeniales()

func conectarSeniales() -> void:
	Eventos.connect("nivelIniciado", self, "fadeOut")
	Eventos.connect("nivelTerminado",self, "fadeIn")
	Eventos.connect("detectoZonaRecarga",self, "_on_detectoZonaRecarga")

func fadeIn() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_In")

func fadeOut() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_In")

func _on_detectoZonaRecarga(enZona:bool) -> void:
	if enZona:
		infoZonaRecarga.mostrarSuavizado()
	else:
		infoZonaRecarga.ocultarSuavizado()
