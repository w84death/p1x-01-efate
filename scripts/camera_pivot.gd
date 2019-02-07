extends Position3D

export var rotate_speed = 1.2
export var return_speed = 1.0

const DEADZONE = 0.25

var angle_y = 0
var _angle_y = 180

var axis_value
var axis_abs


func _process(delta):
    if angle_y != _angle_y:
        _angle_y += (angle_y - _angle_y) * delta * 10.0
        if abs(angle_y - _angle_y) < 0.001:
            _angle_y = angle_y

        var basis = Basis(Vector3(0.0, 1.0, 0.0), deg2rad(_angle_y))
        transform.basis = basis


func _physics_process(delta):
    for axis in range(JOY_AXIS_0, JOY_AXIS_MAX):
        axis_value = Input.get_joy_axis(0, axis)
        axis_abs = abs(axis_value)
        if axis_abs > DEADZONE:
            # ROTATE LEFT - RIGHT
            if axis == JOY_ANALOG_RX:
                angle_y -= rotate_speed * axis_value



