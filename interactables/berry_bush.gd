extends StaticBody2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var berries: Node2D = $Berries


func _ready() -> void:
	
	$Sprite.play("default")
func _process(delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	if berries.get_child_count()>0:
		berries.get_child(0).queue_free()
		Globals.add_food_to_stack("berry")
