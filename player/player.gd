extends CharacterBody2D
class_name Player

@export var base_move_speed: float
@export_range(0,1,0.01) var acceleration: float

@onready var bowl: Node2D = $Bowl
@onready var stack: Node2D = $Bowl/Stack
@onready var bowl_start_pos: Vector2 = $Bowl.position
var move_direction: Vector2
var interactables_in_range: Array[Node2D]

func _physics_process(delta: float) -> void:	
	bowl.position.x=lerpf(bowl.position.x,signf(move_direction.x)*30,delta*10)
	bowl.rotation=lerpf(bowl.rotation,signf(move_direction.x)/10,delta*10)
	bowl.position.y=lerpf(bowl.position.y,bowl_start_pos.y,delta*15)
	if Input.is_action_just_pressed("delete_recent_food"):
		if !get_stacked_ingredients().is_empty():
			get_stacked_ingredients()[0].remove()
			bowl.position.y+=4
	
	move_direction=Input.get_vector("move_left","move_right","move_up","move_down")
	velocity+=move_direction*base_move_speed*delta
	velocity*=acceleration
	move_and_slide()
func get_food_stack_dictionary():
	var food_stack_dictionary: Dictionary
	for i in get_food_stack_array().size():
		if food_stack_dictionary.has(get_food_stack_array()[i]):
			food_stack_dictionary[get_food_stack_array()[i]]+=1
		else:
			food_stack_dictionary[get_food_stack_array()[i]]=1
	return food_stack_dictionary
func get_food_stack_array():
	var food_stack: Array
	for i in stack.get_child_count():
		food_stack.insert(i,get_stacked_ingredients()[i].food_name)
	return food_stack
func get_stacked_ingredients():
	var stacked_ingredients: Array[StackedIngredient]
	for i in stack.get_child_count():
		if stack.get_child(i).is_in_group("stacked_ingredient"):
			var iterated_child: StackedIngredient = stack.get_child(i)
			stacked_ingredients.insert(0,iterated_child)
	return stacked_ingredients
func get_closest_interactable():
	if interactables_in_range.size()>0:
		var closest_item=interactables_in_range[0]
		for i in interactables_in_range.size():
			if interactables_in_range[i].position.distance_to(position)<closest_item.position.distance_to(position):
				closest_item=interactables_in_range[i]
		return closest_item
	else:
		return
