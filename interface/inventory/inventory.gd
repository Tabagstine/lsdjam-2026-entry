extends CanvasLayer

@export var inventory_button: PackedScene

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var buttons_container: GridContainer = $ScrollContainer/ButtonsContainer

var inventory_shown: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("show_inventory"):
		if inventory_shown:
			inventory_shown=false
		else:
			inventory_shown=true
	visible=inventory_shown
	
	if get_tree().get_node_count_in_group("player")>0:
		display_hovered_item()
		if buttons_container.get_child_count()!=player.get_food_stack_dictionary().keys().size():
			update_inventory() 
func update_inventory():
	for i in buttons_container.get_child_count():
		buttons_container.get_child(i).queue_free()
	if player.get_food_stack_array().size()>0:
		for i in player.get_food_stack_dictionary().keys().size():
			var new_inventory_button: InventoryButton = inventory_button.instantiate()
			var button_texture=Globals.get_food(player.get_food_stack_dictionary().keys()[i]).stack_sprite.texture
			new_inventory_button.texture_normal=button_texture
			new_inventory_button.modulate=Globals.get_food(player.get_food_stack_dictionary().keys()[i]).stack_sprite.modulate
			new_inventory_button.food_name=player.get_food_stack_dictionary().keys()[i]
			buttons_container.add_child(new_inventory_button)
func display_hovered_item():
	var displayed_item: String
	for i in buttons_container.get_child_count():
		if buttons_container.get_child(i).is_hovered():
			displayed_item=buttons_container.get_child(i).food_name
	$ColorRect2/Label.text=str(displayed_item).to_upper()
