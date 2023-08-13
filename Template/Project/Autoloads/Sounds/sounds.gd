extends Node

const MAX_SIMULTANEOUS_SOUNDS : int = 5

@export var _audio_players : Array
var _pitch_range : float = 0.15
 
func _ready() -> void:
	_create_audio_players(MAX_SIMULTANEOUS_SOUNDS)


func play_sound(sound: AudioStream, pitch_scale: float = 1.0, volume_in_decibels: float = 0.0) -> void:
	if sound == null:
		push_error("Null sound encountered")
		return
		
	var available_player = _find_available_audio_player()
	if available_player != null:
		_configure_audio(available_player, sound, pitch_scale, volume_in_decibels)
		_play_audio_player(available_player)


func _find_available_audio_player() -> AudioStreamPlayer:
	for audioPlayer in _audio_players:
		if audioPlayer == null:
			push_error("No available audio player found")
			continue
		
		if not audioPlayer.playing:
			return audioPlayer
	
	return null


func _configure_audio(player: AudioStreamPlayer, sound: AudioStream, pitch_scale: float, volume_in_decibels: float) -> void:
	player.stream = sound
	player.pitch_scale = pitch_scale + randf_range(-_pitch_range, _pitch_range)
	player.volume_db = volume_in_decibels


func _play_audio_player(player: AudioStreamPlayer) -> void:
	player.play()


func _create_audio_players(max_sound_players):
	for i in range(max_sound_players):
		var audio_player_instance = AudioStreamPlayer.new()
		audio_player_instance.connect("finished", _on_audio_player_finished)
		_audio_players.append(audio_player_instance)
		add_child(audio_player_instance)


func _on_audio_player_finished() -> void:
	print("Sound finished")
