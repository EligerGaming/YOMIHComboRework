extends "res://characters/states/Fall.gd"
#export var _c_NunChuck_Spin = 0
#export var bounceMomentum = "-1.0"

func _ready():
	pass

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	host.apply_force("0", "-3.0")

func on_got_blocked_by(obj):
	if host.get_opponent().is_grounded():
		host.set_vel(host.get_vel().x, "-1.0")
	else:	
		host.apply_force("0", "-3.0")
	interrupt_into.append("ChukJumpFollowup")

func _exit_shared():
	interrupt_into.pop_back()
