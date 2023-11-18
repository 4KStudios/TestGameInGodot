extends CharacterBody2D

@export var health = 100


var in_attack_range = false
var hit_cooldown = true
var dummy_alive = true

func _physics_process(delta):
	player_attack()
	
	if health <= 0:
		self.queue_free()


func dummy():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("dummy"):
		in_attack_range = true


func _on_hitbox_body_exited(body):
	if body.has_method("dummy"):
		in_attack_range = true

func player_attack():
	if in_attack_range && hit_cooldown == true:
		health -= 20
		hit_cooldown = false
		$hitCooldown.start()
		print(health)

func _on_hit_cooldown_timeout():
	hit_cooldown = true
