class_name ContenedorInformacion
extends NinePatchRect

func mostrar() -> void:
	$AnimationPlayer.play("Mostar")
	
func ocultar() -> void:
	$AnimationPlayer.play("Ocultar")
	
func mostrarSuavizado() -> void:
	$AnimationPlayer.play("mostarSuavizado")
	
func ocultarSuavizado() -> void:
	$AnimationPlayer.play("ocultarSuavizado")
