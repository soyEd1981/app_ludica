extends NinePatchRect


var plugin_imagen
var plugin_compartir

onready var despliegue_imagen: TextureRect = $DespliegueImagen
onready var boton_musica: TextureButton = $ContenedorHorizontal/BotonMusica
onready var reproductor_musica: AudioStreamPlayer = $ReproductorMusica


func _ready() -> void:
	if Engine.has_singleton('GodotGetImage'):
		plugin_imagen = Engine.get_singleton('GodotGetImage')
		plugin_imagen.connect('image_request_completed', self, '_establecer_imagen')
	
	if Engine.has_singleton('GodotShare'):
		plugin_compartir = Engine.get_singleton('GodotShare')


func _establecer_imagen(diccionario: Dictionary) -> void:
	for imagen in diccionario.values():
		var imagen_actual := Image.new()
		imagen_actual.load_jpg_from_buffer(imagen)
		yield(get_tree(), "idle_frame")
		var textura := ImageTexture.new()
		textura.create_from_image(imagen_actual, 0)
		despliegue_imagen.texture = textura


func _on_BotonGaleria_pressed() -> void:
	if plugin_imagen:
		plugin_imagen.getGalleryImage()


func _on_BotonCamara_pressed() -> void:
	if plugin_imagen:
		plugin_imagen.getCameraImage()


func _on_BotonRegresar_pressed() -> void:
	get_tree().change_scene("res://Escenas/Principal.tscn")


func _on_BotonCompartir_pressed() -> void:
	## Averiguar cómo guardar una imagen de la cámara.
	#plugin_compartir.shareText('Prueba', 'Prueba de plugin', 'Ésta es una prueba de un plugin para compartir.')
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var imagen = get_viewport().get_texture().get_data()
	var imagen_guardada = OS.get_user_data_dir() + '/imagen_guardada.png'
	imagen.save_png(imagen_guardada)
	plugin_compartir.sharePic(imagen_guardada, 'imagen guardada', 'Prueba compartir imagen', 'Esta es otra prueba del plugin para compartir')


func _on_BotonMusica_pressed() -> void:
	reproductor_musica.playing = !reproductor_musica.playing
	if reproductor_musica.playing:
		boton_musica.texture_normal = load("res://assets/Game Icons/PNG/Black/1x/musicOn.png")
		boton_musica.texture_pressed = load("res://assets/Game Icons/PNG/White/1x/musicOn.png")
	else:
		boton_musica.texture_normal = load("res://assets/Game Icons/PNG/Black/1x/musicOff.png")
		boton_musica.texture_pressed = load("res://assets/Game Icons/PNG/White/1x/musicOff.png")

func _on_BotonSalir_pressed() -> void:
	get_tree().quit()








