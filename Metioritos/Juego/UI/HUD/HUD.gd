class_name HUD
extends CanvasLayer

onready var infoZonaRecarga:ContenedorInformacion = $InfoZonaRecarga
onready var infoMeteoritos:ContenedorInformacion = $InfoMeteoritos
onready var infoTiempoRestante:ContenedorInformacion = $InfoTiempoRestante
onready var infoEnergiaLaser:ContenedorInformacionEnergia = $EnergiaLaser
onready var infoEnergiaEscudo:ContenedorInformacionEnergia = $EnergiaEscudo

func _ready() -> void:
	conectarSeniales()

func conectarSeniales() -> void:
	Eventos.connect("nivelIniciado", self, "fadeOut")
	Eventos.connect("nivelTerminado",self, "fadeIn")
	Eventos.connect("detectoZonaRecarga",self, "_on_detectoZonaRecarga")
	Eventos.connect("cambioNumeroMeteoritos",self,"_on_actualizarInfoMeteorito")
	Eventos.connect("actualizarTiempo",self,"_on_actualizarTiempo")
	Eventos.connect("cambioEnergiaLaser",self,"_on_cambioEnergiaLaser")
	Eventos.connect("ocultarEnergiaLaser",infoEnergiaLaser, "ocultar")
	Eventos.connect("cambioEnergiaEscudo",self,"_on_cambioEnergiaEscudo")
	Eventos.connect("ocultarEnergiaEscudo", infoEnergiaEscudo, "ocultar")
	Eventos.connect("naveDestruida",self,"_on_naveDestruida")


func fadeIn() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_In")

func fadeOut() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_In")

func _on_actualizarInfoMeteorito(numero:int) -> void:
	infoMeteoritos.mostrarSuavizado()
	infoMeteoritos.modificarTexto("Meteoritos Restantes\n {cantidad}".format({"cantidad":numero}))

func _on_actualizarTiempo(tiempoRestante:int) -> void:
	var minutos:int = floor(tiempoRestante * 0.0166666666666667)
	var segundos:int = tiempoRestante % 60
	infoTiempoRestante.modificarTexto("Tiempo Restante\n%02d:%02d" % [minutos, segundos])
	
	if tiempoRestante % 10 == 0:
		infoTiempoRestante.mostrarSuavizado()
	
	if tiempoRestante == 11:
		infoTiempoRestante.set_autoOcultar(false)
	elif tiempoRestante == 0:
		infoTiempoRestante.ocultar()

func _on_cambioEnergiaLaser(EnergiaMax:float, energiaActual:float) -> void:
	infoEnergiaLaser.mostrar()
	infoEnergiaLaser.actualizarEnergia(EnergiaMax,energiaActual)

func _on_cambioEnergiaEscudo(EnergiaMax:float, energiaActual:float) -> void:
	infoEnergiaEscudo.mostrar()
	infoEnergiaEscudo.actualizarEnergia(EnergiaMax,energiaActual)

func _on_detectoZonaRecarga(enZona:bool) -> void:
	if enZona:
		infoZonaRecarga.mostrarSuavizado()
	else:
		infoZonaRecarga.ocultarSuavizado()

func _on_naveDestruida(nave: Nave, _posiciom,_explosiones) -> void:
	if nave is Player:
		get_tree().call_group("ContenedorInfo", "set_estaActivo", false)
		get_tree().call_group("ContenedorInfo", "ocultar")
