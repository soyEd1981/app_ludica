extends Node

# https://audionautix.com/creative-commons-music
# music by audionautix.com
# <a href="https://audionautix.com/">Creative Commons Music by Jason Shaw on Audionautix.com</a>
# <a href="https://audionautix.com/">Music by Audionautix.com</a>
# https://www.youtube.com/playlist?list=PLQl2eWiUO8_K1BcuBjRRq5_z5xqkLosRu

"""
Esta aplicación es para probar lo siguiente en el dispositivo Android:
	* Uso de la cámara
	* Admobs
	* Notificaciones locales
	* Compartir textos e imágenes desde la app
	* Obtención de ubicación
	* Compras desde la app (In-App purchases)
	* Text To Speech (TTS) y Speech To Text (STT)
	* Exportación y publicación en Google Play
	"""

var plugin_notificaciones

onready var dialogo_popup: AcceptDialog = $Fondo/DialogoPopUp
onready var nombre_popup: AcceptDialog = $Fondo/NombrePopup
onready var opciones: ItemList = $Fondo/Opciones
onready var reproductor_musica: AudioStreamPlayer = $ReproductorMusica
onready var datos_horario := OS.get_datetime()
onready var nombre_usuario := GlobalDatos.cargar()


func _ready() -> void:
	if Engine.has_singleton('LocalNotification'):
		plugin_notificaciones = Engine.get_singleton('LocalNotification')
	dialogo_popup.get_close_button().hide()
	
	if nombre_usuario:
		nombre_popup.popup_centered()
		nombre_popup.dialog_text = 'Bienvenido al juego, ' + nombre_usuario


func _on_Opciones_item_selected(index: int) -> void:
	if index == 0:
		get_tree().change_scene("res://Escenas/PantallaImagen.tscn")
	elif index == 1:
		pass
	elif index == 2:
		pass
		#get_tree().change_scene("res://Escenas/PantallaCapturaDatos.tscn")
	elif index == 3:
		dialogo_popup.popup()
	elif index == 4:
		reproductor_musica.playing = !reproductor_musica.playing
		if opciones.is_selected(4):
			opciones.unselect(4)
		if reproductor_musica.playing:
			opciones.set_item_icon(4, load("res://assets/Game Icons/PNG/Black/1x/musicOn.png"))
		else:
			opciones.set_item_icon(4, load("res://assets/Game Icons/PNG/Black/1x/musicOff.png"))
	elif index == 5:
		get_tree().quit()
#		plugin_notificaciones.showLocalNotification('Ésta es una prueba', 
#			'Prueba' + str(datos_horario['day']) + '/' + str(datos_horario['month'])
#				+ '/' + str(datos_horario['year']) + ' -- ' + str(datos_horario['hour']) + ':' +
#				str(datos_horario['minute']), 2, 1)
		plugin_notificaciones.showRepeatingNotification('Ésta es una notificación periódica',
				'Notificación: ' + str(datos_horario['day']) + '/' + str(datos_horario['month'])
				+ '/' + str(datos_horario['year']) + ' -- ' + str(datos_horario['hour']) + ':' +
				str(datos_horario['minute']),
				1, 1, 1)
	elif index == 6:
		get_tree().change_scene("res://Escenas/PantallaCapturaDatos.tscn")




