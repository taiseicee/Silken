extends Node

var ui: CanvasLayer

var cocoon_count: int = 0
var player_health: int = 100

func add_cocoon():
	cocoon_count += 1
	print("Cocoon Count: - %d" % [globals.cocoon_count])
	if ui && "update_cocoon_count" in ui:
		ui.update_cocoon_count()

func add_player_health(value: int):
	player_health += value
	print("Player Health: - %d" % [globals.player_health])
	if ui && "update_health" in ui:
		ui.update_health()
