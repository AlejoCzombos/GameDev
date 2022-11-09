class_name ContenedorInformacionEnergia
extends ContenedorInformacion

onready var medidor:ProgressBar = $ProgressBar

func actualizarEnergia(energiaMax: float, energiaActual:float) -> void:
	var energiaPorcentual:int = (energiaActual * 100) / energiaMax
	medidor.value = energiaPorcentual
