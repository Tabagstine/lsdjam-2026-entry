extends Node2D
class_name IngredientStackDisplay
var stack_number: int
var height: float
var stack_order: Array[int]

func _process(_delta: float) -> void:
	$Label.text=str(stack_number)
func remove():
	queue_free()
