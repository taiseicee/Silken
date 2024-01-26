extends CanvasLayer

@onready var text_label: Label = $margin_container/dialogue_panel/text_container/HBoxContainer/text

func set_text(text: String):
	text_label.text = text
