class_name Minimapa
extends MarginContainer

export var escalaZoom:float = 4.0
export var tiempoVisible:float = 5.0

var escalaGrilla:Vector2
var player:Player = null

onready var zonaRenderizado:TextureRect = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa
onready var iconoPlayer:Sprite = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa/IconoPlayer
onready var iconoRecarga:Sprite = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa/IconoRecarga
onready var iconoBaseEnemiga:Sprite = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa/IconoBaseEnemigo
onready var iconoRele:Sprite = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa/IconoRele
onready var iconoInterceptor:Sprite = $CuadroMiniMapa/ContenedorIconos/ZonaRenderizadorMiniMapa/IconoInterceptor
onready var itemsMiniMapa:Dictionary = {}
onready var timerVisibilidad:Timer = $TimerVisibilidad
onready var tweenVisibilidad:Tween = $TweenVisibilidad

var estaVisible:bool = true setget set_estaVisible

func set_estaVisible(visible:bool) -> void:
	if visible:
		timerVisibilidad.start()
	estaVisible = visible
	tweenVisibilidad.interpolate_property(self,"modulate", Color(1,1,1,not visible), Color(1,1,1,visible), 0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tweenVisibilidad.start()

func _ready() -> void:
	set_process(false)
	iconoPlayer.position = zonaRenderizado.rect_size * 0.5
	escalaGrilla = zonaRenderizado.rect_size / (get_viewport_rect().size * escalaZoom)
	conectarSeniales()

func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("minimapa"):
		set_estaVisible(not estaVisible)

func conectarSeniales() -> void:
	Eventos.connect("nivelIniciado",self,"_on_nivelIniciado")
	Eventos.connect("naveDestruida",self,"_on_naveDestruida")
	Eventos.connect("minimapaObjetoCreado",self,"obtenerObjetosMinimapa")
	Eventos.connect("minimapaObjetoDestruido",self,"quitarIcono")
	

func _process(_delta:float) -> void:
	if not player:
		return
	
	iconoPlayer.rotation_degrees = player.rotation_degrees + 90
	modificarPosicionesIconos()

func _on_nivelIniciado() -> void:
	player = DatosJuego.get_playerActual()
	obtenerObjetosMinimapa()
	set_process(true)

func obtenerObjetosMinimapa() -> void:
	var objetosEnVentana:Array = get_tree().get_nodes_in_group("Minimapa")
	for objeto in objetosEnVentana:
		if not itemsMiniMapa.has(objeto):
			var spriteIcono:Sprite
			if objeto is BaseEnemiga:
				spriteIcono = iconoBaseEnemiga.duplicate()
			elif objeto is EstacionRecarga:
				spriteIcono = iconoRecarga.duplicate()
			elif objeto is EnemigoInterceptor:
				spriteIcono = iconoInterceptor.duplicate()
			elif objeto is ReleDeMasa:
				spriteIcono = iconoRele.duplicate()
			itemsMiniMapa[objeto] = spriteIcono
			itemsMiniMapa[objeto].visible = true
			zonaRenderizado.add_child(itemsMiniMapa[objeto])

func _on_naveDestruida(nave:Nave, _posicion,_explosiones) -> void:
	if nave is Player:
		player = null

func modificarPosicionesIconos() -> void:
	for item in itemsMiniMapa:
		var itemIcono:Sprite = itemsMiniMapa[item]
		var offsetPosicion: Vector2 = item.position - player.position
		#var posisionIcono:Vector2 = offsetPosicion * escalaGrilla + (zonaRenderizado.rect_size * 0.5)
		var posisionIcono:Vector2 = offsetPosicion * escalaGrilla + iconoPlayer.position
		posisionIcono.x = clamp(posisionIcono.x,0,zonaRenderizado.rect_size.x)
		posisionIcono.y = clamp(posisionIcono.y,0,zonaRenderizado.rect_size.y)
		itemIcono.position = posisionIcono
		
		if zonaRenderizado.get_rect().has_point(posisionIcono - zonaRenderizado.rect_position):
			itemIcono.scale = Vector2(0.5,0.5)
		else:
			itemIcono.scale = Vector2(0.3,0.3)

func quitarIcono(objeto:Node2D) -> void:
	if objeto in itemsMiniMapa:
		itemsMiniMapa[objeto].queue_free()
		itemsMiniMapa.erase(objeto)


func _on_TimerVisibilidad_timeout():
	if estaVisible:
		set_estaVisible(false)
