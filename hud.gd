extends CanvasLayer

@onready var time_display: Label = $TimeDisplay

func _process(_delta: float) -> void:
	var seconds=fmod(Globals.time_left,60)
	var minutes=Globals.time_left/60
	var final_time := "%01d:%02d"%[minutes,seconds]
	time_display.text=final_time
