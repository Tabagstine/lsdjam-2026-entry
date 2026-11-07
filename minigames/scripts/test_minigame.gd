extends MinigameBase
@onready var quality_one: Button = $SubViewport/GridContainer/QualityOne
@onready var qaulity_zero: Button = $SubViewport/GridContainer/QaulityZero
@onready var quality_half: Button = $SubViewport/GridContainer/QualityHalf

func _on_quality_one_pressed() -> void:
	minigame_complete()
	food_quality=1

func _on_qaulity_zero_pressed() -> void:
	minigame_complete()
	food_quality=0

func _on_quality_half_pressed() -> void:
	minigame_complete()
	food_quality=0.5
