extends CanvasLayer

@onready var bar_health: TextureProgressBar = $ui_container/bar_health
@onready var label_cocoon: Label = $ui_container/label_cocoon

func update_health():
	bar_health.value = globals.player_health

func update_cocoon_count():
	label_cocoon.text = str(globals.cocoon_count)
