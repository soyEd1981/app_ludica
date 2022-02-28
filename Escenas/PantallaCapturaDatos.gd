extends NinePatchRect

"""Antes de cargar la pantalla principal, debe aparecer la pantalla de registro, que guarda 
los datos del jugador de manera persistente, y los carga a través las de diferentes pantallas."""

var nombre_usuario: String


func _on_CapturaNombre_text_changed(new_text: String) -> String:
	nombre_usuario = new_text
	return nombre_usuario


func _on_BotonConfirmacion_pressed() -> void:
	GlobalDatos.salvar(nombre_usuario)
	get_tree().change_scene("res://Escenas/Principal.tscn")


