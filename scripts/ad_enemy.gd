extends CharacterBody2D

enum AdType {
	POPUP,
	BANNER,
	MALWARE,
	CLICKBAIT
}

@export var ad_type: AdType = AdType.POPUP
@export var patrol_speed: float = 100.0
@export var patrol_distance: float = 200.0

var start_position: Vector2
var patrol_direction: int = 1
const GRAVITY: float = 1500.0

func _ready() -> void:
	start_position = position
	_create_ad_visual()

func _create_ad_visual() -> void:
	match ad_type:
		AdType.POPUP:
			_create_popup()
		AdType.BANNER:
			_create_banner()
		AdType.MALWARE:
			_create_malware()
		AdType.CLICKBAIT:
			_create_clickbait()

func _create_popup() -> void:
	var bg := ColorRect.new()
	bg.size = Vector2(100, 80)
	bg.position = Vector2(-50, -40)
	bg.color = Color.WHITE
	add_child(bg)
	
	var border := ColorRect.new()
	border.size = Vector2(90, 70)
	border.position = Vector2(5, 5)
	border.color = Color(1.0, 0.2, 0.2)
	bg.add_child(border)
	
	var label := Label.new()
	label.text = "CLIQUEZ\nICI!"
	label.position = Vector2(10, 15)
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color.WHITE)
	border.add_child(label)

func _create_banner() -> void:
	var bg := ColorRect.new()
	bg.size = Vector2(120, 50)
	bg.position = Vector2(-60, -25)
	bg.color = Color(0.2, 0.6, 1.0)
	add_child(bg)
	
	var label := Label.new()
	label.text = "PROMO!"
	label.position = Vector2(25, 10)
	label.add_theme_font_size_override("font_size", 20)
	label.add_theme_color_override("font_color", Color.YELLOW)
	bg.add_child(label)

func _create_malware() -> void:
	var bg := ColorRect.new()
	bg.size = Vector2(90, 90)
	bg.position = Vector2(-45, -45)
	bg.color = Color(0.5, 0.0, 0.5)
	add_child(bg)
	
	var skull := Label.new()
	skull.text = "☠"
	skull.position = Vector2(20, 15)
	skull.add_theme_font_size_override("font_size", 40)
	skull.add_theme_color_override("font_color", Color.RED)
	bg.add_child(skull)
	
	var label := Label.new()
	label.text = "VIRUS"
	label.position = Vector2(15, 55)
	label.add_theme_font_size_override("font_size", 14)
	label.add_theme_color_override("font_color", Color.WHITE)
	bg.add_child(label)

func _create_clickbait() -> void:
	var bg := ColorRect.new()
	bg.size = Vector2(110, 70)
	bg.position = Vector2(-55, -35)
	bg.color = Color(1.0, 0.8, 0.0)
	add_child(bg)
	
	var label := Label.new()
	label.text = "Vous ne\ncroirez pas!"
	label.position = Vector2(5, 10)
	label.add_theme_font_size_override("font_size", 14)
	label.add_theme_color_override("font_color", Color.BLACK)
	bg.add_child(label)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	
	velocity.x = patrol_direction * patrol_speed
	
	if abs(position.x - start_position.x) > patrol_distance:
		patrol_direction *= -1
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		if collider and collider.has_method("take_damage"):
			collider.take_damage(1)
