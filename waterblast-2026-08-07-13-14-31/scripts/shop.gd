extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_2_pressed() -> void:
	if pistol < 4:
		pistol += 1
		player.upgrade_pistol()
		$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
	

func _on_rifle_upgrade_pressed() -> void:
	
	if rifle < 4:
		rifle += 1
		player.upgrade_rifle()
		$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'


func _on_shotgun_upgrade_pressed() -> void:
	if shotgun < 4:
		shotgun += 1
		player.upgrade_shotgun()
		$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
		


func _on_washer_upgrade_pressed() -> void:
	if washer < 4:
		washer += 1
		player.upgrade_washer()
		$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
