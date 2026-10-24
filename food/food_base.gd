extends StaticBody2D
class_name Food

@export var food_name: String = "food_name"

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var player: Player =get_tree().get_first_node_in_group("player")


func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	queue_free()
	player.food_stack_order.insert(player.food_stack_order.size(),food_name)
	if player.foods_carried.has(food_name):
		player.foods_carried[food_name]+=1
	else:
		player.foods_carried[food_name]=1
	print(player.food_stack_order)
