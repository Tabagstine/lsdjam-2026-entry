extends CharacterBody2D
class_name Player

@export var base_move_speed: float
@export_range(0,1,0.01) var acceleration: float

@onready var bowl: Node2D = $Bowl
@onready var bowl_start_pos: Vector2 = $Bowl.position
var food_stack_order: Array
var foods_carried: Dictionary
var move_direction: Vector2

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("m"):
		Globals.add_food_to_stack("apple")
	
	bowl.position.x=lerpf(bowl.position.x,signf(move_direction.x)*30,delta*10)
	bowl.rotation=lerpf(bowl.rotation,signf(move_direction.x)/10,delta*10)
	bowl.position.y=lerpf(bowl.position.y,bowl_start_pos.y,delta*15)
	if Input.is_action_just_pressed("delete_recent_food"):
		if !food_stack_order.is_empty():
			bowl.position.y+=4
			var recent_food:String=food_stack_order[food_stack_order.size()-1]
			Globals.remove_food_from_stack(recent_food)
	$Label.text=str(foods_carried)
	
	move_direction=Input.get_vector("move_left","move_right","move_up","move_down")
	velocity+=move_direction*base_move_speed*delta
	velocity*=acceleration
	move_and_slide()
