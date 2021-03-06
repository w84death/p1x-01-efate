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

func _on_quit_pressed():
    quit_game()
    
func _on_scene1_pressed():
    get_tree().change_scene("scenes/scene1.tscn")

func _on_scene2_pressed():
    get_tree().change_scene("scenes/scene2.tscn")

func _on_scene3_pressed():
    get_tree().change_scene("scenes/scene3.tscn")

func _on_scene4_pressed():
    get_tree().change_scene("scenes/scene4.tscn")

func _on_scene5_pressed():
    get_tree().change_scene("scenes/scene5.tscn")



func _on_scene50_pressed():
    get_tree().change_scene("scenes/scene50.tscn")
    
func _on_scene52_pressed():
    get_tree().change_scene("scenes/scene52.tscn")

func _on_scene53_pressed():
    get_tree().change_scene("scenes/scene53.tscn")




func _on_settings_pressed():
    $main.play("settings")

func _on_back_pressed():
    $main.play("menu")