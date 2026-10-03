extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0

@onready var rifleCoin = $Control/Rifle/Coin
@onready var rifleLock = $Control/Rifle/Lock
@onready var rifleUpgrade = $Control/Rifle/rifleUpgrade

@onready var shotgunCoin = $Control/Shotgun/Coin
@onready var shotgunLock = $Control/Shotgun/Lock
@onready var shotgunUpgrade = $Control/Shotgun/shotgunUpgrade

@onready var washerCoin = $Control/Washer/Coin
@onready var washerLock = $Control/Washer/Lock
@onready var washerUpgrade = $Control/Washer/washerUpgrade



func _process(delta):
	
	if player.availableUnlocks >= 1:
		
		rifleLock.visible = false
		
		if "rifle" in player.unlockedWeapons:
			rifleCoin.visible = false
			rifleUpgrade.visible = true
		else:
			rifleCoin.visible = true
	
	
	if player.availableUnlocks >= 2:
		
		shotgunLock.visible = false
		
		if "shotgun" in player.unlockedWeapons:
			shotgunCoin.visible = false
			shotgunUpgrade.visible = true
		else:
			shotgunCoin.visible = true
	
	
	if player.availableUnlocks >= 3:
		
		washerLock.visible = false
		
		if "washer" in player.unlockedWeapons:
			washerCoin.visible = false
			washerUpgrade.visible = true
		else:
			washerCoin.visible = true

func _on_button_2_pressed() -> void:
	if pistol < 4:
		
		var hasUpgraded = false
		
		if pistol == 0 and player.playerCoins >= 10:
			player.upgrade_pistol()
			player.playerCoins += -10
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 20"
			hasUpgraded = true
		
		if pistol == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -20
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 50"
			hasUpgraded = true

		if pistol == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -50
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 100"
			hasUpgraded = true
		
		if pistol == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -100
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Max Level"
			hasUpgraded = true
		
		

func _on_rifle_upgrade_pressed() -> void:
	if rifle < 4 and "rifle" in player.unlockedWeapons:
		
		var hasUpgraded = false
		
		if rifle == 0 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -50
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 120"
			hasUpgraded = true
			
		if rifle == 1 and player.playerCoins >= 120 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -120
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 250"
			hasUpgraded = true
			
		if rifle == 2 and player.playerCoins >= 250 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -250
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 400"
			hasUpgraded = true
		
		if rifle == 3 and player.playerCoins >= 400 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -400
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Max Level"
			hasUpgraded = true
		
		


func _on_shotgun_upgrade_pressed() -> void:
	if shotgun < 4 and "shotgun" in player.unlockedWeapons:
		
		var hasUpgraded = false
		
		if shotgun == 0 and player.playerCoins >= 10 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -10
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Cost: 20"
			hasUpgraded = true
			
		if shotgun == 1 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -20
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Cost: 50"
			hasUpgraded = true
			
		if shotgun == 2 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -50
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Cost: 100"
			hasUpgraded = true
		
		if shotgun == 3 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_shotgun()
			player.playerCoins += -100
			shotgun += 1
			$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(shotgun) + ')'
			$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Max Level"
			hasUpgraded = true


func _on_washer_upgrade_pressed() -> void:
	if washer < 4 and "washer" in player.unlockedWeapons:
		
		var hasUpgraded = false
		
		if washer == 0 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -50
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			$Control/Washer/washerUpgrade/WasherCostLabel.text = "Cost: 100"
			hasUpgraded = true
			
		if washer == 1 and player.playerCoins >= 100 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -100
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			$Control/Washer/washerUpgrade/WasherCostLabel.text = "Cost: 220"
			hasUpgraded = true
			
		if washer == 2 and player.playerCoins >= 220 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -220
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			$Control/Washer/washerUpgrade/WasherCostLabel.text = "Cost: 500"
			hasUpgraded = true
		
		if washer == 3 and player.playerCoins >= 500 and hasUpgraded == false:
			player.upgrade_washer()
			player.playerCoins += -500
			washer += 1
			$Control/Washer/washerUpgrade.text = "Upgrade (" + str(washer) + ')'
			$Control/Washer/washerUpgrade/WasherCostLabel.text = "Max Level"
			hasUpgraded = true


func _on_pistol_button_pressed() -> void:
	player.change_weapon(0)


func _on_rifle_button_pressed() -> void:
	if player.availableUnlocks >= 1 and player.playerCoins >= 60:
		player.playerCoins += -60
		player.unlockedWeapons.append("rifle")
		player.change_weapon(1)


func _on_shotgun_button_pressed() -> void:
	if player.availableUnlocks >= 2 and player.playerCoins >= 100:
		player.playerCoins += -100
		player.unlockedWeapons.append("shotgun")
		player.change_weapon(2)


func _on_washer_button_pressed() -> void:
	if player.availableUnlocks >= 3 and player.playerCoins >= 250:
		player.playerCoins += -250
		player.unlockedWeapons.append("washer")
		player.change_weapon(3)
