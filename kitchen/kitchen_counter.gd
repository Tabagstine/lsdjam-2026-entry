extends StaticBody2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()

func interacted():
	var attempted_food:Recipe=Globals.get_food_result()
	if attempted_food.recipe_name!="failed":
		for i in player.get_food_stack_array().size():
			player.stack.remove_child(player.stack.get_child(0))
		Globals.add_food_to_stack(attempted_food.recipe_name,1)
