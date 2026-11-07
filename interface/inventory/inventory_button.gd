extends TextureButton
class_name InventoryButton

@onready var amount: Label = $Amount
@onready var player: Player = get_tree().get_first_node_in_group("player")

var display_value: int = 0
var food_name: String


func _process(_delta: float) -> void:
	if player.get_food_stack_dictionary().has(food_name):
		display_value=player.get_food_stack_dictionary()[food_name]
		amount.text=": "+str(display_value)
	
	var color_change_speed:=0.4
	if is_hovered():
		self_modulate=lerp(self_modulate,Color(2.454, 2.454, 2.454, 1.0),color_change_speed)
	else:
		self_modulate=lerp(self_modulate,Color(1.0, 1.0, 1.0, 1.0),color_change_speed)
func _pressed() -> void:
	Globals.remove_specific_food_from_stack(food_name)
