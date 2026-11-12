extends StaticBody2D

@export var defualt_minigame: PackedScene
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	var attempted_food:Recipe=Globals.get_food_result()
	if attempted_food.recipe_name!="failed":
		var new_minigame=defualt_minigame.instantiate()
		new_minigame.food_result=attempted_food.recipe_name
		new_minigame.position=Vector2(180,90)
		Globals.hud.add_child(new_minigame)
