extends CharacterBody2D

var ball_sc = preload("res://Scenes/ball_bounce.tscn")

var level = 1
var ballAmmo = 1

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if ballAmmo >= 1:
		
		if Input.is_action_just_pressed("fire"):
			shoot_ball()
	else:
		pass

func shoot_ball():
	$BulletspawnTime.start()

func _on_bulletspawn_time_timeout():
	if ballAmmo > 0:
		ballAmmo -= 1
		var ball_inst:ball = ball_sc.instantiate()
		ball_inst.transform = $SpawnBall.global_transform
		owner.add_child(ball_inst)
		if ballAmmo == 0:
			$BulletspawnTime.stop()
			level += 1
			ballAmmo = level
	#print("level = ",level)
	#print("Ammo = ",ballAmmo)
