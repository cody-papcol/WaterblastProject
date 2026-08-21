extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0


func _on_button_2_pressed() -> void:
	if pistol < 4:
		
		var hasUpgraded = false
		
		if pistol == 0 and player.playerCoins >= 10:
			player.upgrade_pistol()
			player.playerCoins += -10
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			hasUpgraded = true
		
		if pistol == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -20
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			hasUpgraded = true

		if pistol == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -50
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			hasUpgraded = true
		
		if pistol == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -100
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			hasUpgraded = true
		
		

func _on_rifle_upgrade_pressed() -> void:
	if rifle < 4:
		
		var hasUpgraded = false
		
		if rifle == 0 and player.playerCoins >= 10 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -10
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			hasUpgraded = true
			
		if rifle == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -20
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			hasUpgraded = true
			
		if rifle == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -50
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			hasUpgraded = true
		
		if rifle == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -100
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			hasUpgraded = true
		
		


func _on_shotgun_upgrade_pressed() -> void:
	if shotgun < 4:
		
		var hasUpgraded = false
		
		if shotgun == 0 and player.playerCoins >= 10 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -10
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			hasUpgraded = true
			
		if shotgun == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -20
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			hasUpgraded = true
			
		if shotgun == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -50
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			hasUpgraded = true
		
		if shotgun == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -100
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			hasUpgraded = true


func _on_washer_upgrade_pressed() -> void:
	if washer < 4:
		
		var hasUpgraded = false
		
		if washer == 0 and player.playerCoins >= 10 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -10
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			hasUpgraded = true
			
		if washer == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -20
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			hasUpgraded = true
			
		if washer == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -50
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			hasUpgraded = true
		
		if washer == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -100
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			hasUpgraded = true
