extends CharacterBody2D
class_name Player

@export var base_move_speed: float
@export_range(0,1,0.01) var acceleration: float

var food_stack_order: Array
var foods_carried: Dictionary
var move_direction: Vector2

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("get_recipe"):
		Globals.get_food_result()
	if Input.is_action_just_pressed("delete_recent_food"):
		if !food_stack_order.is_empty():
			Globals.remove_food_from_stack(food_stack_order[food_stack_order.size()-1])
	$Label.text=str(foods_carried)
	
	move_direction=Input.get_vector("move_left","move_right","move_up","move_down")
	velocity+=move_direction*base_move_speed*delta
	velocity*=acceleration
	move_and_slide()
