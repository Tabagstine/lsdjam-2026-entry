extends StaticBody2D
class_name Food

@export var food_name: String = "food_name"
@export var stack_sprite: Sprite2D
@export var weight: float = 1

@onready var interactable_component: InteractableComponent = $InteractableComponent
var ingredient_display=preload("res://food/food_stack/stacked_ingredient.tscn")

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	Globals.add_food_to_stack(food_name)
	queue_free()
