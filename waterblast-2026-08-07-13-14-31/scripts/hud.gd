extends CanvasLayer

@onready var ammoLabel: Label = $Control/AmmoLabel
@onready var player: CharacterBody3D = $".."
@onready var healthBar: ProgressBar = $Control/HealthBar
@onready var fpsLabel: Label = $Control/FPSLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ammoLabel.text = str(player.ammo) + "/" + str(player.max_ammo)
	healthBar.value = player.health
	fpsLabel.text = str(Engine.get_frames_per_second())
