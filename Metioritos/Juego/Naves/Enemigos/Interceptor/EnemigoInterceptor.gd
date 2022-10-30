class_name EnemigoInterceptor
extends EnemigoBase

enum ESTADO_IA{IDLE, ATACANDOQ, ATACANDOP, PERSECUCION}

export var potenciaMax:float = 800.0

var estadoIAactual = ESTADO_IA.IDLE
var potenciaActual:float = 0.0

func _integrate_forces(state:Physics2DDirectBodyState) -> void:
	linear_velocity += dirPlayer.normalized() * potenciaActual * state.get_step()
	
	linear_velocity.x = clamp(linear_velocity.x, -potenciaMax, potenciaMax)
	linear_velocity.y = clamp(linear_velocity.y, -potenciaMax, potenciaMax)

func controladorEstadoIA(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO_IA.IDLE:
			canion.set_estaDisparando(false)
			potenciaActual = 0.0
		ESTADO_IA.ATACANDOQ:
			canion.set_estaDisparando(true)
			potenciaActual = 0.0
		ESTADO_IA.ATACANDOP:
			canion.set_estaDisparando(true)
			potenciaActual = potenciaMax
		ESTADO_IA.PERSECUCION:
			canion.set_estaDisparando(false)
			potenciaActual = potenciaMax
		_:
			printerr("Error estados")
	estadoIAactual = nuevoEstado

func _on_AreaDisparo_body_entered(_body) -> void:
	controladorEstadoIA(ESTADO_IA.ATACANDOQ)

func _on_AreaDisparo_body_exited(_body) -> void:
	controladorEstadoIA(ESTADO_IA.ATACANDOP)

func _on_AreaDeteccion_body_entered(_body) -> void:
	controladorEstadoIA(ESTADO_IA.ATACANDOQ)

func _on_AreaDeteccion_body_exited(_body) -> void:
	controladorEstadoIA(ESTADO_IA.PERSECUCION)
