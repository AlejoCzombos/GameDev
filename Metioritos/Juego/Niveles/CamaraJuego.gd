class_name CamaraJuego
extends Camera2D

var zoomOriginal:Vector2
var puedeHacerseZoom:bool = true setget set_puedeHacerseZoom

onready var tweenZoom: Tween = $TweenZoom

func set_puedeHacerseZoom(puede:bool) -> void:
	puedeHacerseZoom = puede

func _ready() -> void:
	zoomOriginal = zoom

func devolverZoomOriginal() -> void:
	puedeHacerseZoom = false
	zoomSuavizado(zoomOriginal.x, zoomOriginal.y, 1.5)

func zoomSuavizado(nuevoZoomX: float, nuevoZoomY: float, tiempoTransicion: float) -> void:
	tweenZoom.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(nuevoZoomX,nuevoZoomY),
		tiempoTransicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	tweenZoom.start()


