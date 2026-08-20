extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0


func _on_button_2_pressed() -> void:
	if pistol < 4:
		if pistol == 0 and player.playerCoins >= 10:
			player.upgrade_pistol()
			player.playerCoins += -10
			
		if pistol == 1 and player.playerCoins >= 30:
			player.upgrade_pistol()
			player.playerCoins += -20
			
		if pistol == 2 and player.playerCoins >= 100:
			player.upgrade_pistol()
			player.playerCoins += -50
		
		if pistol == 3 and player.playerCoins >= 250:
			player.upgrade_pistol()
			player.playerCoins += -100
		
		pistol += 1
		$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'

func _on_rifle_upgrade_pressed() -> void:
	if rifle < 4:
		if rifle == 0 and player.playerCoins >= 10:
			player.upgrade_rifle()
			player.playerCoins += -10
			
		if rifle == 1 and player.playerCoins >= 30:
			player.upgrade_rifle()
			player.playerCoins += -20
			
		if rifle == 2 and player.playerCoins >= 100:
			player.upgrade_rifle()
			player.playerCoins += -50
		
		if rifle == 3 and player.playerCoins >= 250:
			player.upgrade_rifle()
			player.playerCoins += -100
		
		rifle += 1
		$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'


func _on_shotgun_upgrade_pressed() -> void:
	if shotgun < 4:
		if shotgun == 0 and player.playerCoins >= 10:
			player.upgrade_shotgun()
			player.playerCoins += -10
			
		if shotgun == 1 and player.playerCoins >= 30:
			player.upgrade_shotgun()
			player.playerCoins += -20
			
		if shotgun == 2 and player.playerCoins >= 100:
			player.upgrade_shotgun()
			player.playerCoins += -50
		
		if shotgun == 3 and player.playerCoins >= 250:
			player.upgrade_shotgun()
			player.playerCoins += -100
		
		shotgun += 1
		$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
		


func _on_washer_upgrade_pressed() -> void:
	if washer < 4:
		if washer == 0 and player.playerCoins >= 10:
			player.upgrade_washer()
			player.playerCoins += -10
			
		if washer == 1 and player.playerCoins >= 30:
			player.upgrade_washer()
			player.playerCoins += -20
			
		if washer == 2 and player.playerCoins >= 100:
			player.upgrade_washer()
			player.playerCoins += -50
		
		if washer == 3 and player.playerCoins >= 250:
			player.upgrade_washer()
			player.playerCoins += -100
		
		washer += 1
		$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
