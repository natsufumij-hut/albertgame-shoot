extends Node2D

@onready var solo_option: Control = $HUD/SoloOption

func _on_solo_pressed() -> void:
	solo_option.show()


func _on_solo_close_pressed() -> void:
	solo_option.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()
