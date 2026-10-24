extends Node
class_name InteractableComponent

@export var body: Node2D
@export var interaction_range: float
@export var interaction_visual: Node

@onready var target=get_tree().get_first_node_in_group("player")

var in_range: bool
var interacted: bool

func tick():
	if interaction_visual!=null:
		if body.global_position.distance_to(target.global_position)<interaction_range:
			in_range=true
		else:
			in_range=false
			
	interaction_visual.visible=in_range
	if in_range and interacted:
		if body.has_method("interacted"):
			body.interacted()
	pass
