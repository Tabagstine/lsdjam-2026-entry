extends CharacterBody2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

var requested_food: String = "fruit_salad"
var anger: float = 0

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	if Globals.player.get_food_stack_array().has(requested_food):
		for i in Globals.player.get_stacked_ingredients().size():
			if Globals.player.get_stacked_ingredients()[i].food_name==requested_food:
				if Globals.player.get_stacked_ingredients()[i].food_quality>=0.5:
					send_to_new_zone()
				Globals.remove_specific_food_from_stack(requested_food)
				break
func send_to_new_zone():
	get_tree().change_scene_to_file("res://zones/purple_world.tscn")
