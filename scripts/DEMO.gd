extends Spatial

#
# P1X 01 - Efate
#
# https://github.com/w84death/p1x-01-efate
# https://p1x.in
#
export var INIT = false
export var NEXT_SCENE_NUMBER = 1

func _ready():
    if INIT:
        next_scene()

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        quit_game()

func quit_game():
    get_tree().quit()

func _on_quit_pressed():
    quit_game()

func next_scene():
    get_tree().change_scene("scenes/scene" + str(NEXT_SCENE_NUMBER) + ".tscn")

func bake_gi():
    $"GIProbe".bake()
    pass