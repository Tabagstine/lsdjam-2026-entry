extends Node
class_name InteractableComponent

@export var debug: bool
@export var body: Node2D
@export var interaction_range: float
@export var interaction_visual: Node


var can_interact: bool = false
var interacted: bool = false
var in_range: bool = false

func _ready() -> void:
	Globals.connect("update_interactables_in_range",add_to_interactables_in_range)
func tick():
	var target=get_tree().get_first_node_in_group("player")
	if target!=null:
		if interaction_visual!=null:
			var closest: bool = target.get_closest_interactable()==body
			in_range = body.global_position.distance_to(target.global_position)<interaction_range
			if closest and in_range:
				can_interact=true
			else:
				can_interact=false
		interaction_visual.visible=can_interact
		if can_interact and interacted:
			if body.has_method("interacted"):
				body.interacted()
		pass
func add_to_interactables_in_range():
	if in_range:
		var target=get_tree().get_first_node_in_group("player")
		target.interactables_in_range.insert(0,body)
