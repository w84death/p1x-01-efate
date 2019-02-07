extends Spatial

export var MAP_SIZE = Vector2(512, 512)
export var MAP_HEIGHT_FACTOR = 32
onready var world_map = preload("res://materials/terrain/noise_terrain_forest.tres")

onready var player = $"player"

var barrel

var height_map

func _ready():
    var noise = world_map.get_noise()
    height_map = noise.get_image(MAP_SIZE[0], MAP_SIZE[1])


func get_height(pos, below_water=false):
    var pos2 = convert_pos(pos)
    height_map.lock()
    var h = height_map.get_pixel(pos2.x, pos2.y).r
    height_map.unlock()
    var terrain_h = h * MAP_HEIGHT_FACTOR
    #print(terrain_h)
    return terrain_h

func convert_pos(pos):
    return Vector2(int(MAP_SIZE.x*.5+pos.x), int(MAP_SIZE.y*.5+pos.z))


func set_graphics_settings(gfx_type):
    if gfx_type == "PERF_HI":
        $sun.shadow_enabled = true
        ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 8192)
        ProjectSettings.set_setting("rendering/quality/reflections/high_quality_ggx", true)
        ProjectSettings.set_setting("rendering/quality/voxel_cone_tracing/high_quality", true)
        ProjectSettings.set_setting("rendering/quality/shading/force_vertex_shading", false)
        get_viewport().msaa = Viewport.MSAA_4X
        ProjectSettings.set_setting("rendering/quality/shadows/filter_mode", 2)
        $environment.environment.dof_blur_far_enabled = true
        $environment.environment.dof_blur_far_distance = 512
        $environment.environment.dof_blur_far_transition = 8
        $environment.environment.dof_blur_far_amount = 0.1
        $environment.environment.dof_blur_far_quality = Environment.DOF_BLUR_QUALITY_MEDIUM
        $environment.environment.ss_reflections_max_steps = 256
        $environment.environment.glow_enabled = true
        $environment.environment.glow_bloom = 0.3
 
    if gfx_type == "PERF_NORMAL":
        $sun.shadow_enabled = true
        ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 4096)
        ProjectSettings.set_setting("rendering/quality/reflections/high_quality_ggx", false)
        ProjectSettings.set_setting("rendering/quality/voxel_cone_tracing/high_quality", false)
        ProjectSettings.set_setting("rendering/quality/shading/force_vertex_shading", false)
        get_viewport().msaa = Viewport.MSAA_DISABLED
        ProjectSettings.set_setting("rendering/quality/shadows/filter_mode", 1)
        $environment.environment.dof_blur_far_enabled = false
        $environment.environment.ss_reflections_max_steps = 128
        $environment.environment.glow_enabled = false
        
    if gfx_type == "PERF_LOW":
        $sun.shadow_enabled = false
        ProjectSettings.set_setting("rendering/quality/directional_shadow/size", 2048)
        ProjectSettings.set_setting("rendering/quality/reflections/high_quality_ggx", false)
        ProjectSettings.set_setting("rendering/quality/voxel_cone_tracing/high_quality", false)
        ProjectSettings.set_setting("rendering/quality/shading/force_vertex_shading", true)
        get_viewport().msaa = Viewport.MSAA_DISABLED
        ProjectSettings.set_setting("rendering/quality/shadows/filter_mode", 0)
        $environment.environment.dof_blur_far_enabled = false
        $environment.environment.ss_reflections_max_steps = 64
        $environment.environment.glow_enabled = false