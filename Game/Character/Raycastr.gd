extends Spatial

var ground = true


func  check()->float:
	
	return abs($RayCast.get_collision_normal().x+$RayCast.get_collision_normal().z+$RayCast.get_collision_normal().y)

