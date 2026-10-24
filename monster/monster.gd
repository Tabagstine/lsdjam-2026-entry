extends CharacterBody2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _process(_delta: float) -> void:
	interactable_component.interacted=Input.is_action_just_pressed("interact")
	interactable_component.tick()
func interacted():
	print("hi")
