extends TextureButton
class_name InventoryButton

@onready var amount: Label = $Amount

var display_value: int = 0
var food_name: String


func _process(_delta: float) -> void:
	if Globals.player.get_food_stack_dictionary().has(food_name):
		display_value=Globals.player.get_food_stack_dictionary()[food_name]
		amount.text=": "+str(display_value)
	
	if get_parent().get_parent().get_parent().inventory_shown:
		var color_change_speed:=0.4
		if is_hovered():
			self_modulate=lerp(self_modulate,Color(2.454, 2.454, 2.454, 1.0),color_change_speed)
		else:
			self_modulate=lerp(self_modulate,Color(1.0, 1.0, 1.0, 1.0),color_change_speed)
func _pressed() -> void:
	Globals.remove_specific_food_from_stack(food_name)
