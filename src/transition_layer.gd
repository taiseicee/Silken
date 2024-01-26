extends CanvasLayer

@onready var fade_to_black: AnimationPlayer = $fade_to_black
@onready var reset_scene: Timer = $reset_scene

func change_scene(target: PackedScene):
	fade_to_black.play("fade_to_black")
	await fade_to_black.animation_finished
	get_tree().change_scene_to_packed(target)
	fade_to_black.play_backwards("fade_to_black")

func end_scene():
	fade_to_black.play("fade_to_black")
	await fade_to_black.animation_finished

func start_scene():
	reset_scene.start()

func _on_reset_scene_timeout():
	get_tree().reload_current_scene()
	fade_to_black.play_backwards("fade_to_black")
