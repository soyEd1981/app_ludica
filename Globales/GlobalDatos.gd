extends Node

func salvar(contenido) -> void:
	var archivo: File = File.new()
	archivo.open('user://datos_guardados.dat', File.WRITE)
	archivo.store_string(contenido)
	archivo.close()


func cargar() -> String:
	var archivo: File = File.new()
	archivo.open('user://datos_guardados.dat', File.READ)
	var contenido = archivo.get_as_text()
	archivo.close()
	return contenido
