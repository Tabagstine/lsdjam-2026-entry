extends Node2D
class_name HarvestableItem

@export var sway_amount: float = 40
@export var sway_speed: float = 10
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var items: Node2D = $Items

var sway_tick: float = randf_range(0,1000)

func _ready() -> void:
	sprite.play("default")
func _process(delta: float) -> void:
	sway_tick+=delta*sway_speed/10
	skew=sin(sway_tick)*sway_amount/100
	scale.y=(cos(sway_tick)*sway_amount/300)+1
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
	if items.get_child_count()<=0:
		$Interact.visible=false
func interacted():
	if items.get_child_count()>0:
		items.get_child(0).queue_free()
		Globals.add_food_to_stack(items.get_child(0).product)
