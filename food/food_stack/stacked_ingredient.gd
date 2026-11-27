extends Node2D
class_name StackedIngredient
var stack_number: int
var height: float
var stack_order: Array[int]
var food_name: String = "stacked_ingredient"
var food_quality: float = 1.0

func remove():
	queue_free()
