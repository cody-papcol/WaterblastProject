extends CanvasLayer

@onready var ammoLabel: Label = $Control/AmmoLabel
@onready var player: CharacterBody3D = $".."
@onready var healthBar: ProgressBar = $Control/HealthBar
@onready var fpsLabel: Label = $Control/FPSLabel
@onready var waveLabel: Label = $Control/WaveLabel
@onready var leftInWaveLabel: Label = $Control/LeftInWaveLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ammoLabel.text = str(player.ammo) + "/" + str(player.max_ammo)
	healthBar.value = (player.health/player.maxHealth) * 100
	fpsLabel.text = str(Engine.get_frames_per_second())
	
	if CurrentLevelManager.endless_mode:
		waveLabel.text = "Wave: " + str(player.wave)
	else:
		waveLabel.text = "Wave: " + str(player.wave) + "/" + str(player.totalWaves)
	leftInWaveLabel.text = "Remaining: " + str(int(player.leftInWave))
	
