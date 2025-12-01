extends Node2D

@onready var player_scene := preload("res://scenes/player.tscn")
@onready var ad_enemy_scene := preload("res://scenes/ad_enemy.tscn")

var player: CharacterBody2D
var score: int = 0
var coins_collected: int = 0
var game_running: bool = false

# UI Elements
var score_label: Label
var health_label: Label
var game_over_label: Label
var start_button: Button
var restart_button: Button
var ad_warning_label: Label

# AdMob Manager
var admob_manager: Node

func _ready() -> void:
	_setup_admob()
	_create_level()
	_setup_ui()
	_show_start_screen()

func _setup_admob() -> void:
	# Créer et ajouter le gestionnaire AdMob
	var AdMobScript = load("res://scripts/admob_manager.gd")
	admob_manager = AdMobScript.new()
	admob_manager.name = "AdMobManager"
	add_child(admob_manager)
	admob_manager.ad_closed.connect(_on_ad_closed)

func _create_level() -> void:
	# Sol
	var floor := StaticBody2D.new()
	floor.name = "Floor"
	add_child(floor)
	
	var floor_shape := CollisionShape2D.new()
	var rect_shape := RectangleShape2D.new()
	rect_shape.size = Vector2(2000, 100)
	floor_shape.shape = rect_shape
	floor_shape.position = Vector2(0, 600)
	floor.add_child(floor_shape)
	
	var floor_visual := ColorRect.new()
	floor_visual.size = Vector2(2000, 100)
	floor_visual.position = Vector2(-1000, 550)
	floor_visual.color = Color(0.3, 0.2, 0.1)
	floor.add_child(floor_visual)
	
	# Plateformes
	_create_platform(Vector2(300, 450), Vector2(200, 30))
	_create_platform(Vector2(600, 350), Vector2(200, 30))
	_create_platform(Vector2(-300, 400), Vector2(200, 30))
	_create_platform(Vector2(-600, 300), Vector2(180, 30))
	_create_platform(Vector2(0, 250), Vector2(250, 30))

func _create_platform(pos: Vector2, size: Vector2) -> void:
	var platform := StaticBody2D.new()
	add_child(platform)
	
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = size
	collision.shape = shape
	collision.position = pos
	platform.add_child(collision)
	
	var visual := ColorRect.new()
	visual.size = size
	visual.position = pos - size / 2
	visual.color = Color(0.5, 0.3, 0.2)
	platform.add_child(visual)

func _setup_ui() -> void:
	var screen_size := get_viewport_rect().size
	
	# Score
	score_label = Label.new()
	score_label.position = Vector2(20, 20)
	score_label.add_theme_font_size_override("font_size", 28)
	score_label.add_theme_color_override("font_color", Color.YELLOW)
	add_child(score_label)
	
	# Santé
	health_label = Label.new()
	health_label.position = Vector2(20, 60)
	health_label.add_theme_font_size_override("font_size", 28)
	health_label.add_theme_color_override("font_color", Color.RED)
	add_child(health_label)
	
	# Game Over
	game_over_label = Label.new()
	game_over_label.position = Vector2(screen_size.x / 2 - 200, screen_size.y / 2 - 150)
	game_over_label.add_theme_font_size_override("font_size", 48)
	game_over_label.add_theme_color_override("font_color", Color.RED)
	game_over_label.visible = false
	add_child(game_over_label)
	
	# Avertissement pub
	ad_warning_label = Label.new()
	ad_warning_label.text = "⚠️ Une pub va s'afficher... ⚠️"
	ad_warning_label.position = Vector2(screen_size.x / 2 - 200, screen_size.y / 2 - 50)
	ad_warning_label.add_theme_font_size_override("font_size", 32)
	ad_warning_label.add_theme_color_override("font_color", Color.ORANGE)
	ad_warning_label.visible = false
	add_child(ad_warning_label)
	
	# Boutons
	start_button = Button.new()
	start_button.text = "DÉMARRER"
	start_button.position = Vector2(screen_size.x / 2 - 100, screen_size.y / 2 - 30)
	start_button.size = Vector2(200, 60)
	start_button.add_theme_font_size_override("font_size", 24)
	start_button.pressed.connect(_start_game)
	add_child(start_button)
	
	restart_button = Button.new()
	restart_button.text = "REJOUER"
	restart_button.position = Vector2(screen_size.x / 2 - 100, screen_size.y / 2 + 100)
	restart_button.size = Vector2(200, 60)
	restart_button.add_theme_font_size_override("font_size", 24)
	restart_button.pressed.connect(_restart_game)
	restart_button.visible = false
	add_child(restart_button)
	
	# Titre
	var title := Label.new()
	title.text = "FERRARI vs PUBS"
	title.position = Vector2(screen_size.x / 2 - 250, 80)
	title.add_theme_font_size_override("font_size", 56)
	title.add_theme_color_override("font_color", Color.RED)
	title.name = "Title"
	add_child(title)
	
	# Instructions
	var instructions := Label.new()
	instructions.text = "Platformer 2D\n\nFlèches = Bouger | ESPACE = Sauter\nÉvitez les pubs ennemies!\n\n💀 Si vous mourez, une VRAIE pub s'affiche! 💀"
	instructions.position = Vector2(screen_size.x / 2 - 280, 180)
	instructions.add_theme_font_size_override("font_size", 20)
	instructions.add_theme_color_override("font_color", Color.WHITE)
	instructions.name = "Instructions"
	add_child(instructions)

func _show_start_screen() -> void:
	start_button.visible = true
	restart_button.visible = false
	game_over_label.visible = false
	ad_warning_label.visible = false
	get_node("Title").visible = true
	get_node("Instructions").visible = true
	score_label.visible = false
	health_label.visible = false

func _start_game() -> void:
	start_button.visible = false
	get_node("Title").visible = false
	get_node("Instructions").visible = false
	score_label.visible = true
	health_label.visible = true
	
	score = 0
	coins_collected = 0
	game_running = true
	
	_clear_game_entities()
	_spawn_player()
	_spawn_enemies()
	_update_ui()

func _spawn_player() -> void:
	player = player_scene.instantiate()
	player.position = Vector2(0, 300)
	player.died.connect(_on_player_died)
	player.health_changed.connect(_on_player_health_changed)
	add_child(player)

func _spawn_enemies() -> void:
	var enemy_positions = [
		Vector2(400, 400),
		Vector2(-400, 350),
		Vector2(700, 300),
		Vector2(-700, 250)
	]
	
	for i in range(enemy_positions.size()):
		var enemy := ad_enemy_scene.instantiate()
		enemy.position = enemy_positions[i]
		enemy.ad_type = i % 4  # Alterner les types
		add_child(enemy)

func _clear_game_entities() -> void:
	for child in get_children():
		if child is CharacterBody2D and child != self:
			child.queue_free()

func _on_player_died() -> void:
	game_running = false
	
	# Afficher l'avertissement
	ad_warning_label.visible = true
	await get_tree().create_timer(1.5).timeout
	ad_warning_label.visible = false
	
	# AFFICHER LA VRAIE PUB AdMob
	admob_manager.show_death_ad()

func _on_ad_closed() -> void:
	# Afficher l'écran game over après la pub
	_show_game_over()

func _show_game_over() -> void:
	game_over_label.text = "GAME OVER!\n\nScore: %d\nPièces: %d" % [score, coins_collected]
	game_over_label.visible = true
	restart_button.visible = true

func _on_player_health_changed(new_health: int) -> void:
	_update_ui()

func _update_ui() -> void:
	if player:
		score_label.text = "Score: %d" % score
		health_label.text = "❤️ x %d" % player.health

func _restart_game() -> void:
	restart_button.visible = false
	game_over_label.visible = false
	_start_game()

func _process(_delta: float) -> void:
	if game_running and player:
		# Camera suit le joueur
		var camera_offset := player.position
		camera_offset.x = clamp(camera_offset.x, -400, 400)
		position = -camera_offset + get_viewport_rect().size / 2
