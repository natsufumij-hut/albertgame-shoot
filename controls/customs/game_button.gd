extends Button

@export var click_audio: AudioStream
@export var hover_audio: AudioStream
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_mouse_entered() -> void:
	if hover_audio:
		audio_stream_player.stream = hover_audio
		audio_stream_player.play()


func _on_button_down() -> void:
	if click_audio:
		audio_stream_player.stream = click_audio
		audio_stream_player.play()


func _on_focus_entered() -> void:
	if hover_audio:
		audio_stream_player.stream = hover_audio
		audio_stream_player.play()
