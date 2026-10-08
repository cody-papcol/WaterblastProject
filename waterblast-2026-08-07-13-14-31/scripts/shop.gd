extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0
var healthLevel = 0
var speedLevel = 0
var reloadLevel = 0

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
		
		if pistol == 0 and player.playerCoins >= 5:
			player.upgrade_pistol()
			player.playerCoins += -5
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 10"
			hasUpgraded = true
		
		if pistol == 1 and player.playerCoins >= 10 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -10
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 20"
			hasUpgraded = true

		if pistol == 2 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -20
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: 35"
			hasUpgraded = true
		
		if pistol == 3 and player.playerCoins >= 35 and hasUpgraded == false:
			player.upgrade_pistol()
			player.playerCoins += -35
			pistol += 1
			$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(pistol) + ')'
			$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Max Level"
			hasUpgraded = true
		
		

func _on_rifle_upgrade_pressed() -> void:
	if rifle < 4 and "rifle" in player.unlockedWeapons:
		
		var hasUpgraded = false
		
		if rifle == 0 and player.playerCoins >= 20 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -20
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 50"
			hasUpgraded = true
			
		if rifle == 1 and player.playerCoins >= 50 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -50
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 85"
			hasUpgraded = true
			
		if rifle == 2 and player.playerCoins >= 85 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -85
			rifle += 1
			$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(rifle) + ')'
			$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: 120"
			hasUpgraded = true
		
		if rifle == 3 and player.playerCoins >= 120 and hasUpgraded == false:
			player.upgrade_rifle()
			player.playerCoins += -120
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
	if player.availableUnlocks >= 1 and player.playerCoins >= 30 and not "rifle" in player.unlockedWeapons:
		player.playerCoins += -30
		player.unlockedWeapons.append("rifle")
		player.change_weapon(1)
		
	elif "rifle" in player.unlockedWeapons:
		player.change_weapon(1)

func _on_shotgun_button_pressed() -> void:
	if player.availableUnlocks >= 2 and player.playerCoins >= 80 and not "shotgun" in player.unlockedWeapons:
		player.playerCoins += -80
		player.unlockedWeapons.append("shotgun")
		player.change_weapon(2)
	
	elif "shotgun" in player.unlockedWeapons:
		player.change_weapon(2)


func _on_washer_button_pressed() -> void:
	if player.availableUnlocks >= 3 and player.playerCoins >= 150 and not "washer" in player.unlockedWeapons:
		player.playerCoins += -150
		player.unlockedWeapons.append("washer")
		player.change_weapon(3)
	
	elif "washer" in player.unlockedWeapons:
		player.change_weapon(3)


func _on_health_upgrade_pressed():
	if healthLevel < 5:
		
		if healthLevel == 0 and player.playerCoins >= 20:
			player.maxHealth += 20
			player._damage(-20)
			player.playerCoins -= 20
			healthLevel += 1
			$Control/PlayerUpgrades/HealthUpgrade.text = "+20 Max Health (" + str(healthLevel) + ')'
			$Control/PlayerUpgrades/HealthUpgrade/healthUpgradeCost.text = "Cost: 40"
		
		elif healthLevel == 1 and player.playerCoins >= 40:
			player.maxHealth += 20
			player._damage(-20)
			player.playerCoins -= 40
			healthLevel += 1
			$Control/PlayerUpgrades/HealthUpgrade.text = "+20 Max Health (" + str(healthLevel) + ')'
			$Control/PlayerUpgrades/HealthUpgrade/healthUpgradeCost.text = "Cost: 60"
		
		elif healthLevel == 2 and player.playerCoins >= 60:
			player.maxHealth += 20
			player._damage(-20)
			player.playerCoins -= 60
			healthLevel += 1
			$Control/PlayerUpgrades/HealthUpgrade.text = "+20 Max Health (" + str(healthLevel) + ')'
			$Control/PlayerUpgrades/HealthUpgrade/healthUpgradeCost.text = "Cost: 80"
			
		elif healthLevel == 3 and player.playerCoins >= 80:
			player.maxHealth += 20
			player._damage(-20)
			player.playerCoins -= 80
			healthLevel += 1
			$Control/PlayerUpgrades/HealthUpgrade.text = "+20 Max Health (" + str(healthLevel) + ')'
			$Control/PlayerUpgrades/HealthUpgrade/healthUpgradeCost.text = "Cost: 100"
			
		elif healthLevel == 4 and player.playerCoins >= 100:
			player.maxHealth += 20
			player._damage(-20)
			player.playerCoins -= 100
			healthLevel += 1
			$Control/PlayerUpgrades/HealthUpgrade.text = "Max Level"
			$Control/PlayerUpgrades/HealthUpgrade/healthUpgradeCost.text = ""


func _on_speed_upgrade_pressed():
	if speedLevel < 5:
		
		if speedLevel == 0 and player.playerCoins >= 20:
			player.WALK_SPEED += 0.5
			player.SPRINT_SPEED += 0.5
			player.playerCoins -= 20
			speedLevel += 1
			$Control/PlayerUpgrades/SpeedUpgrade.text = "+0.5 Speed (" + str(speedLevel) + ')'
			$Control/PlayerUpgrades/SpeedUpgrade/SpeedUpgradeCost.text = "Cost: 40"
		
		elif speedLevel == 1 and player.playerCoins >= 40:
			player.WALK_SPEED += 0.5
			player.SPRINT_SPEED += 0.5
			player.playerCoins -= 40
			speedLevel += 1
			$Control/PlayerUpgrades/SpeedUpgrade.text = "+0.5 Speed (" + str(speedLevel) + ')'
			$Control/PlayerUpgrades/SpeedUpgrade/SpeedUpgradeCost.text = "Cost: 60"
		
		elif speedLevel == 2 and player.playerCoins >= 60:
			player.WALK_SPEED += 0.5
			player.SPRINT_SPEED += 0.5
			player.playerCoins -= 60
			speedLevel += 1
			$Control/PlayerUpgrades/SpeedUpgrade.text = "+0.5 Speed (" + str(speedLevel) + ')'
			$Control/PlayerUpgrades/SpeedUpgrade/SpeedUpgradeCost.text = "Cost: 80"
			
		elif speedLevel == 3 and player.playerCoins >= 80:
			player.WALK_SPEED += 0.5
			player.SPRINT_SPEED += 0.5
			player.playerCoins -= 80
			speedLevel += 1
			$Control/PlayerUpgrades/SpeedUpgrade.text = "+0.5 Speed (" + str(speedLevel) + ')'
			$Control/PlayerUpgrades/SpeedUpgrade/SpeedUpgradeCost.text = "Cost: 100"
			
		elif speedLevel == 4 and player.playerCoins >= 100:
			player.WALK_SPEED += 0.5
			player.SPRINT_SPEED += 0.5
			player.playerCoins -= 100
			speedLevel += 1
			$Control/PlayerUpgrades/SpeedUpgrade.text = "Max Level"
			$Control/PlayerUpgrades/SpeedUpgrade/SpeedUpgradeCost.text = ""


func _on_reload_upgrade_pressed():
	if reloadLevel < 5:
		
		if reloadLevel == 0 and player.playerCoins >= 20:
			player.reloadSpeedMulti += 0.2
			player.playerCoins -= 20
			reloadLevel += 1
			$Control/PlayerUpgrades/ReloadUpgrade.text = "+0.2x Reload Speed (" + str(reloadLevel) + ')'
			$Control/PlayerUpgrades/ReloadUpgrade/ReloadUpgradeCost.text = "Cost: 40"
		
		elif reloadLevel == 1 and player.playerCoins >= 40:
			player.reloadSpeedMulti += 0.2
			player.playerCoins -= 40
			reloadLevel += 1
			$Control/PlayerUpgrades/ReloadUpgrade.text = "+0.2x Reload Speed (" + str(reloadLevel) + ')'
			$Control/PlayerUpgrades/ReloadUpgrade/ReloadUpgradeCost.text = "Cost: 60"
		
		elif reloadLevel == 2 and player.playerCoins >= 60:
			player.reloadSpeedMulti += 0.2
			player.playerCoins -= 60
			reloadLevel += 1
			$Control/PlayerUpgrades/ReloadUpgrade.text = "+0.2x Reload Speed (" + str(reloadLevel) + ')'
			$Control/PlayerUpgrades/ReloadUpgrade/ReloadUpgradeCost.text = "Cost: 80"
			
		elif reloadLevel == 3 and player.playerCoins >= 80:
			player.reloadSpeedMulti += 0.2
			player.playerCoins -= 80
			reloadLevel += 1
			$Control/PlayerUpgrades/ReloadUpgrade.text = "+0.2x Reload Speed (" + str(reloadLevel) + ')'
			$Control/PlayerUpgrades/ReloadUpgrade/ReloadUpgradeCost.text = "Cost: 100"
			
		elif reloadLevel == 4 and player.playerCoins >= 100:
			player.reloadSpeedMulti += 0.2
			player.playerCoins -= 100
			reloadLevel += 1
			$Control/PlayerUpgrades/ReloadUpgrade.text = "Max Level"
			$Control/PlayerUpgrades/ReloadUpgrade/ReloadUpgradeCost.text = ""
