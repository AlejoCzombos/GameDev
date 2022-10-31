extends Node

signal disparo(proyectil)
signal naveDestruida(nave, posicion, explosiones)
signal naveEnSectorPeligro(centroCamara, tipoPeligro, numeroPeligros)
signal baseDestruida(posicion, explosiones)

signal crearMeteorito(posicion, direccion, tamanio)
signal particulasMeteorito(posicion)
signal destruccionMeteorito(posicion)
