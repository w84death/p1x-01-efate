extends Control

#
# P1X 01 - Efate
#
# https://github.com/w84death/p1x-01-efate
# https://p1x.in 
#

func _ready():
    pass # Replace with function body.

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        quit_game()

func quit_game():
    get_tree().quit()

func _on_scene1_pressed():
    get_tree().change_scene("scenes/scene1.tscn")

func _on_scene2_pressed():
    $HUD/bottom/status.show()
    get_tree().change_scene("scenes/scene2.tscn")

func _on_quit_pressed():
    quit_game()
