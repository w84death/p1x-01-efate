
extends Spatial

#
# P1X 01 - Efate
#
# https://github.com/w84death/p1x-01-efate
# https://p1x.in 
#


func _ready():
    pass # Replace with function body.

#warning-ignore:unused_argument
func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE) or Input.is_mouse_button_pressed(BUTTON_RIGHT):
        back()
        
func back():
#warning-ignore:return_value_discarded
    get_tree().change_scene("scenes/main.tscn")
    