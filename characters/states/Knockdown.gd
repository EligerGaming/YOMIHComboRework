extends CharacterState

class_name Getup

const GROUND_FRIC = "0.125"

export var hard = false
var getup = false
var hitstun: int
var hitbox

func _enter():
	if data["hitbox"] != null:
		hitbox = data["hitbox"]
	hitstun = data["hitstun"]

func _frame_0():
#	host.start_invulnerability()
	var vel = host.get_vel()
	host.set_vel(vel.x, "0")
	host.set_grounded(true)
	host.set_pos(host.get_pos().x, 0)
	host.on_the_ground = true
	host.colliding_with_opponent = false
	host.play_sound("HitBass")
	if !host.is_ghost:
		var camera = host.get_camera()
		if camera:
			if hard:
				camera.bump(Vector2.UP, 7, 0.35)
			else:
				camera.bump(Vector2.UP, 6, 0.25)

func _exit():
	host.on_the_ground = false
	host.colliding_with_opponent = true

func _tick():
	if host.hitlag_ticks == 0 && hitstun > 0: #hitstun degredation, also hitstun doesn't go down during hitlag
		hitstun -= 1
	host.apply_x_fric(GROUND_FRIC)
#	host.apply_fric()
	host.apply_forces_no_limit()
#	if host.hp <= 0:
#		endless = true
	if hitstun <= 0 and host.hp > 0: #finishing integrating degrading hitstun
		if getup:
			return fallback_state
		else:
			getup = true
