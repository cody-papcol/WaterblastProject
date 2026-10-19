extends Node

var music_playing = false

func play_music():
	if music_playing == false:
		$MusicPlayer.play()
		music_playing = true
	
func stop_music():
	$MusicPlayer.stop()
	music_playing = false
	

func _on_music_player_finished():
	$MusicPlayer.play()
