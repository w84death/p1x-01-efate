extends Label

var fps = 0
export var LABEL_PREFIX = 'FPS: '

func _ready():
    pass

func _process(delta):
    var current_fps = Performance.get_monitor(Performance.TIME_FPS)
    if current_fps > fps:
        fps += 1
    if current_fps < fps:
        fps -= 1
         
    set_text(LABEL_PREFIX + str(fps).pad_zeros(2))