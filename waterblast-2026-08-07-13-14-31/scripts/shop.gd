extends CanvasLayer

@export var player: CharacterBody3D

var pistol = 0
var rifle = 0
var shotgun = 0
var washer = 0
var healthLevel = 0
var speedLevel = 0
var reloadLevel = 0

var weapons = ['pistol', 'rifle', 'shotgun', 'washer']
var weaponLevels = [0, 0, 0, 0]

var pistolCosts = [5, 10, 20, 35]
var rifleCosts = [20, 50, 85, 120]
var shotgunCosts = [10, 20, 50, 100]
var washerCosts = [50, 100, 220, 500]

var weaponCosts = [pistolCosts, rifleCosts, shotgunCosts, washerCosts]

@onready var weaponCoins = [$Control/Rifle/Coin, $Control/Shotgun/Coin, $Control/Washer/Coin]
@onready var weaponLocks = [$Control/Rifle/Lock, $Control/Shotgun/Lock, $Control/Washer/Lock]
@onready var weaponUpgrades = [$Control/Rifle/rifleUpgrade, $Control/Shotgun/shotgunUpgrade, $Control/Washer/washerUpgrade]

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
	_upgrade_weapon(0)
		
func _on_rifle_upgrade_pressed() -> void:
	_upgrade_weapon(1)
		
func _on_shotgun_upgrade_pressed() -> void:
	_upgrade_weapon(2)

func _on_washer_upgrade_pressed() -> void:
	_upgrade_weapon(3)

# upgrades the weapon depending on which is getting upgraded.
func _upgrade_weapon(weapon):
	
	# if the selected weapon is not already max level and the player actually has the weapon
	if weaponLevels[weapon] < 4 and weapons[weapon] in player.unlockedWeapons:
		var hasUpgraded = false
		
		# iterates through each upgrade level to see what upgrade is needed, and only upgrades once
		for levelValue in 4:
			if hasUpgraded == false:
				
				# checks for correct upgrade level and if player has enough coins to do so
				if weaponLevels[weapon] == levelValue and player.playerCoins >= weaponCosts[weapon][levelValue]:
					
					# update value
					weaponLevels[weapon] += 1
					
					# the actual upgrade and updating the text
					if weapon == 0:
						player.upgrade_pistol()
						$Control/Pistol/pistolUpgrade.text = "Upgrade (" + str(weaponLevels[weapon]) + ')'
						if weaponLevels[weapon] > 3:
							$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Max Level"
						else:
							$Control/Pistol/pistolUpgrade/PistolCostLabel.text = "Cost: " + str(weaponCosts[weapon][weaponLevels[weapon]])
					elif weapon == 1:
						player.upgrade_rifle()
						$Control/Rifle/rifleUpgrade.text = "Upgrade (" + str(weaponLevels[weapon]) + ')'
						if weaponLevels[weapon] > 3:
							$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Max Level"
						else:
							$Control/Rifle/rifleUpgrade/RifleCostLabel.text = "Cost: " + str(weaponCosts[weapon][weaponLevels[weapon]])
					elif weapon == 2:
						player.upgrade_shotgun()
						$Control/Shotgun/shotgunUpgrade.text = "Upgrade (" + str(weaponLevels[weapon]) + ')'
						if weaponLevels[weapon] > 3:
							$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Max Level"
						else:
							$Control/Shotgun/shotgunUpgrade/ShotgunCostLabel.text = "Cost: " + str(weaponCosts[weapon][weaponLevels[weapon]])
					elif weapon == 3:
						player.upgrade_washer()
						$Control/Washer/washerUpgrade.text = "Upgrade (" + str(weaponLevels[weapon]) + ')'
						if weaponLevels[weapon] > 3:
							$Control/Washer/washerUpgrade/WasherCostLabel.text = "Max Level"
						else:
							$Control/Washer/washerUpgrade/WasherCostLabel.text = "Cost: " + str(weaponCosts[weapon][weaponLevels[weapon]])
					
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
