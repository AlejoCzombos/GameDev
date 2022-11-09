extends Node

signal disparo(proyectil)
signal naveDestruida(nave, posicion, explosiones)
signal naveEnSectorPeligro(centroCamara, tipoPeligro, numeroPeligros)
signal baseDestruida(base,posicion)

signal crearMeteorito(posicion, direccion, tamanio)
signal particulasMeteorito(posicion)
signal destruccionMeteorito(posicion)
signal spawnOrbital(orbital)

signal nivelIniciado()
signal nivelTerminado()
signal detectoZonaRecarga(deteccion)

#HUD
signal cambioNumeroMeteoritos(numero)
signal actualizarTiempo(tiempoRestante)
signal cambioEnergiaLaser(energiaMax,energiaActual)
signal ocultarEnergiaLaser()
signal cambioEnergiaEscudo(energiaMax,energiaActual)
signal ocultarEnergiaEscudo()
