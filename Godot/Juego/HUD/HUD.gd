extends Control

onready var etiquetasVidas = $ContenedorInfo/Cantidad
onready var EtiquetaMonedaOro = $ContenedorMonedaOro/Cantidad
onready var EtiquetaMonedaPlata = $ContenedorMonedaPlata/Cantidad
onready var EtiquetaMonedaBronce = $ContenedorMonedaBronce/Cantidad
onready var etiquetaLlaves = $ContenedorLlaves/Cantidad

func _ready():
# warning-ignore:return_value_discarded
	DatosPlayer.connect("actualizarDatos", self, "actualizarHud")
	actualizarHud()

func actualizarHud():
	etiquetasVidas.text = "%s" % DatosPlayer.vidas
	etiquetaLlaves.text = "%s" % DatosPlayer.llaves
	EtiquetaMonedaOro.text = "%s" % DatosPlayer.monedasOro
	EtiquetaMonedaPlata.text = "%s" % DatosPlayer.monedasPlata
	EtiquetaMonedaBronce.text = "%s" % DatosPlayer.monedasBronce
