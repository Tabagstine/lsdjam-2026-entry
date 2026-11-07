extends SubViewportContainer
class_name MinigameBase

##What happens when you run out of time.
@export var time_out_penalties: Array[String] = ["nothing"]
##How long the minigame lasts. If set to 0 the minigame doesn't have a timer.
@export var minigame_duration: float

@onready var minigame_timer: Timer = $MinigameTimer
@onready var time_progress_bar: ProgressBar = $SubViewport/TimeProgressBar
@onready var label: Label = $SubViewport/Label

var food_quality: float = 1
var food_result: String

func _ready() -> void:
	if minigame_duration>0:
		minigame_timer.wait_time=minigame_duration
		minigame_timer.start()
	else:
		time_progress_bar.visible=false
func _process(_delta: float) -> void:
	label.text=food_result
	time_progress_bar.value=minigame_timer.time_left/minigame_timer.wait_time
	if minigame_timer.time_left<=0 and minigame_duration>0:
		queue_free()
func minigame_complete():
	queue_free()
	var player: Player = get_tree().get_first_node_in_group("player")
	for i in player.get_food_stack_array().size():
		player.stack.remove_child(player.stack.get_child(0))
	Globals.add_food_to_stack(food_result,food_quality)
