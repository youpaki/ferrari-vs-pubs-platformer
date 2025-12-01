extends CharacterBody2D

# Constantes de mouvement platformer
const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0
const GRAVITY: float = 1500.0
const MAX_FALL_SPEED: float = 1000.0

# État du joueur
var is_dead: bool = false
var health: int = 3

# Signaux
signal died
signal health_changed(new_health: int)

func _ready() -> void:
	_create_visual()

func _create_visual() -> void:
	# Corps de la Ferrari (rectangle rouge horizontal)
	var body := ColorRect.new()
	body.size = Vector2(80, 50)
	body.position = Vector2(-40, -25)
	body.color = Color.RED
	body.name = "Body"
	add_child(body)
	
	# Pare-brise
	var windshield := ColorRect.new()
	windshield.size = Vector2(30, 20)
	windshield.position = Vector2(15, 5)
	windshield.color = Color(0.3, 0.3, 0.9, 0.7)
	body.add_child(windshield)
	
	# Roue gauche
	var wheel_left := ColorRect.new()
	wheel_left.size = Vector2(18, 18)
	wheel_left.position = Vector2(-30, 30)
	wheel_left.color = Color.BLACK
	add_child(wheel_left)
	
	# Roue droite
	var wheel_right := ColorRect.new()
	wheel_right.size = Vector2(18, 18)
	wheel_right.position = Vector2(12, 30)
	wheel_right.color = Color.BLACK
	add_child(wheel_right)
	
	# Phare avant
	var headlight := ColorRect.new()
	headlight.size = Vector2(8, 8)
	headlight.position = Vector2(35, 10)
	headlight.color = Color.YELLOW
	add_child(headlight)

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)
	else:
		velocity.y = 0
	
	# Saut
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Mouvement horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite
		if direction > 0:
			scale.x = 1
		else:
			scale.x = -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 8)
	
	move_and_slide()

func take_damage(amount: int = 1) -> void:
	if is_dead:
		return
	
	health -= amount
	health_changed.emit(health)
	
	# Effet de dégât visuel
	modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	if is_instance_valid(self):
		modulate = Color.WHITE
	
	if health <= 0:
		die()

func die() -> void:
	is_dead = true
	died.emit()
	
	# Animation de mort
	var tween := create_tween()
	tween.tween_property(self, "rotation", PI * 2, 1.0)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.0)

func reset() -> void:
	is_dead = false
	health = 3
	rotation = 0
	modulate = Color.WHITE
	velocity = Vector2.ZERO
	scale.x = 1
	health_changed.emit(health)
