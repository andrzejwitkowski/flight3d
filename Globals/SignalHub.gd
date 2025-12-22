extends Node


signal on_crate_one_off(p_pos: Vector3, scene_name: Spawner.SceneNames)
signal on_create_laser(p_tr: Transform3D, laser_type: Spawner.LaserType)

func emit_create_laser(p_tr: Transform3D, laser_type: Spawner.LaserType) -> void:
	on_create_laser.emit(p_tr, laser_type)

func emit_create_one_off(p_pos: Vector3, scene_name: Spawner.SceneNames) -> void:
	on_crate_one_off.emit(p_pos, scene_name)
