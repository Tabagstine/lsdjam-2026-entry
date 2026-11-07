extends CharacterBody2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var player: Player=get_tree().get_first_node_in_group("player")

var requested_food: String = "fruit_salad"
var anger: float = 0

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	if player.get_food_stack_array().has(requested_food):
		for i in player.get_stacked_ingredients().size():
			if player.get_stacked_ingredients()[i].food_name==requested_food:
				Globals.remove_specific_food_from_stack(requested_food)
				break
