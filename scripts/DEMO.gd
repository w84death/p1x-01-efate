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

func play_scene(id):
    get_tree().change_scene("scenes/scene"+str(id)+".tscn")
    #$'SCENES/scene52'.show();
    #$'SCENES/scene52/main_camera'.set_current(true);
    #$'SCENES/scene52/master'.play("demo");

func run_demo():
    play_scene(52)
    