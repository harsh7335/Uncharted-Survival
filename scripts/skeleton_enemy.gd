extends CharacterBody2D

class_name skeleton

func skeleton():
	pass

var speed = 30
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false 
var can_take_dmg = true

func enemy():
	pass

func _physics_process(delta: float) -> void:
	deal_with_dmg()
	update_health()
	if player_in_attack_zone == false:
		if health > 0:
			if player_chase:
				position += (player.position - position)/speed
				$AnimatedSprite2D.play("walk")
				if (player.position.x - position.x) < 0 :
					$AnimatedSprite2D.flip_h = true
				else:
					$AnimatedSprite2D.flip_h = false
		
			else:
				$AnimatedSprite2D.play("idle")
		if health <= 0:
			pass
	else:
		attack_animation()
	


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_chase = false


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = false

func deal_with_dmg():
	if player_in_attack_zone and global.player_current_attack == true :
		if can_take_dmg == true :
			health = health - 30
			$dmg_cooldown.start()
			can_take_dmg = false
			print("slime health = ",health)
			if health <= 0:
				player_in_attack_zone = false
				$AnimatedSprite2D.play("death")
				$death_timer.start()
				

func _on_dmg_cooldown_timeout() -> void:
	can_take_dmg = true


func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100 :
		healthbar.visible = false
	else:
		healthbar.visible = true 


func _on_death_timer_timeout() -> void:
	print("playing")
	self.queue_free()

func attack_animation():
	if health>0:
		$AnimatedSprite2D.play("attack")
		var attack_anim = true
		return attack_anim

func death():
	if health <= 0:
		return true
