extends Spatial

func _ready():
    pass # Replace with function body.

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE) or Input.is_mouse_button_pressed(BUTTON_RIGHT):
        back()
        
        
func back():
    get_tree().change_scene("scenes/main.tscn")