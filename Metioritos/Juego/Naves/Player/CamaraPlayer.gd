class_name CamaraPlayer
extends CamaraJuego

export var variacionZoom:float = 0.1
export var zoomMinimo:float = 0.8
export var zoomMaximo:float = 1.5

func _unhandled_input(event) -> void:
	if event.is_action_pressed("zoomIN"):
		controlarZoom(-variacionZoom)
	elif event.is_action_pressed("zoomOUT"):
		controlarZoom(variacionZoom)

func controlarZoom(modificarZoon:float) -> void:
	var zoomX = clamp(zoom.x + modificarZoon, zoomMinimo, zoomMaximo)
	var zoomY = clamp(zoom.y + modificarZoon, zoomMinimo, zoomMaximo)
	zoomSuavizado(zoomX, zoomY, 0.15)
