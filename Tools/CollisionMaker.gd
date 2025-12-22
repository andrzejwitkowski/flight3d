@tool
extends EditorScript


func _run():
	
	var editor_selection = EditorInterface.get_selection()
	var selected_nodes = editor_selection.get_selected_nodes()

	for node in selected_nodes:
		if node is MeshInstance3D:
			var mesh_instance: MeshInstance3D = node
			var rb: RigidBody3D = RigidBody3D.new()
			var parent: Node3D = mesh_instance.get_parent()
			
			rb.name = mesh_instance.name + "_RigidBody"
			parent.add_child(rb)
			rb.position = mesh_instance.position
			rb.owner = parent
			rb.gravity_scale = 0.0
			rb.collision_layer = 1 << 4
			rb.collision_mask = 0
			parent.remove_child(mesh_instance)
			rb.add_child(mesh_instance)
			mesh_instance.owner = parent
			mesh_instance.position = Vector3(0,0,0)
			
			
			var collision_shape = CollisionShape3D.new()
			collision_shape.name = mesh_instance.name + "_Collision"
			rb.add_child(collision_shape)
			collision_shape.owner = parent
			
			if mesh_instance.mesh:
				var collision_shape_resource = mesh_instance.mesh.create_convex_shape()
				if collision_shape_resource:
					collision_shape.shape = collision_shape_resource
					collision_shape.transform = mesh_instance.transform
