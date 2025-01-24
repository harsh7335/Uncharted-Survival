extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100 
var player_alive = true
var enemy = null
var attack_ip = false

@export var move_speed : float = 100
@onready var interact_ui = $interact_ui

var current_dir="down"

@export var inv:Inv

func _ready():
	global.set_player_reference(self)

func _physics_process(delta: float):
	
	player_movement(delta)
	enemy_attack()
	attack()
	update_health()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player killed")
		get_tree().reload_current_scene()
	
func player_movement(delta):
	if Input.is_action_pressed("move_right"):
		current_dir="right"
		play_anim(1)
		velocity.x=move_speed
		velocity.y=0
	elif Input.is_action_pressed("move_left"):
		current_dir="left"
		play_anim(1)
		velocity.x=-move_speed
		velocity.y=0
	elif Input.is_action_pressed("move_down"):
		current_dir="down"
		play_anim(1)
		velocity.x=0
		velocity.y=move_speed
	elif Input.is_action_pressed("move_up"):
		current_dir="up"
		play_anim(1)
		velocity.x=0
		velocity.y=-move_speed
	else :
		play_anim(0)
		velocity.x=0
		velocity.y=0
	move_and_slide()
func play_anim(movement):
	var dir=current_dir
	var anim=$AnimatedSprite2D
	
	if dir=="right":
		anim.flip_h = false
		if movement==1:
			anim.play("side_walk")
		elif movement==0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir=="left":
		anim.flip_h = true
		if movement==1:
			anim.play("side_walk")
		elif movement==0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir=="up":
		anim.flip_h = false
		if movement==1:
			anim.play("back_walk")
		elif movement==0:
			if attack_ip == false:
				anim.play("back_idle")
	if dir=="down":
		anim.flip_h = false
		if movement==1:
			anim.play("front_walk")
		elif movement==0:
			if attack_ip == false:
				anim.play("front_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy") :
		enemy = body
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy") :
		enemy = null
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		if enemy.has_method("skeleton"):
			
			$attack_cooldown.wait_time = 0.6
		if enemy.death():
			pass
		else :
			health = health - 20
			enemy_attack_cooldown = false
			$attack_cooldown.start()
			print(health)


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right" :
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left" :
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down" :
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up" :
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
			

func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false 

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100 :
		healthbar.visible = false
	else :
		healthbar.visible = true 
	


func _on_regen_timer_timeout() -> void:
	if health < 100 :
		health = health + 20
		if health > 100 :
			health = 100
	if health <= 0:
		health = 0

func collect(item):
	if item == null:
		pass
	inv.insert(item)
