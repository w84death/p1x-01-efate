extends Spatial

func _ready():
    pass # Replace with function body.

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        quit_game()
        
func back():
    get_tree().change_scene("scenes/main.tscn")

func quit_game():
    get_tree().quit()