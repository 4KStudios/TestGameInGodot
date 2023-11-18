extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jumpforce = 300
@export var health = 100

var enemy_in_attack_range = false
var hit_cooldown = true
var player_alive = true



func _physics_process(delta):
	
	#open menu
	if Input.is_action_just_pressed("open_menu"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
	enemy_attack()
	
	
	#is on floor outputs a boolean
	if !is_on_floor():
		velocity.y += gravity #accelerates
		if velocity.y > 1000: #caps acceleration
			velocity.y = 1000
	
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jumpforce
	
	#horizontal direction outputs a positive or negative value depending on which key is being pressed
	#Inputs buttons are preset in project settings and are given names like move_left and move_right
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
	#moving sprite based on which key is being pressed
	velocity.x = speed * horizontal_direction
	
	#sprint
	if Input.is_action_pressed("sprint"):
		velocity.x += speed * horizontal_direction
		if velocity.x > 600:
			velocity.x = 600
		if velocity.x < -600:
			velocity.x = -600
	
	move_and_slide()

	
	if health <= 0:
		player_alive = false
		self.queue_free()


func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true
		

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false


func enemy_attack():
	if enemy_in_attack_range && hit_cooldown == true:
		health -= 20
		hit_cooldown = false
		$hitCooldown.start()
		print(health)
		

func _on_hit_cooldown_timeout():
	hit_cooldown = true
