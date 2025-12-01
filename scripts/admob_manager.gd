extends Node

# AdMob Manager pour afficher des vraies publicités
# Plugin requis: https://github.com/Poing-Studios/godot-admob-android
# NOTE: AdMob fonctionne UNIQUEMENT sur Android/iOS exporté, PAS dans l'éditeur Godot

# IDs de test AdMob (remplacer par vos vrais IDs en production)
const INTERSTITIAL_AD_UNIT_ID = "ca-app-pub-3940256099942544/1033173712"  # Test ID
const REWARDED_AD_UNIT_ID = "ca-app-pub-3940256099942544/5224354917"  # Test ID

var admob_singleton = null
var is_initialized: bool = false
var interstitial_loaded: bool = false
var is_mobile_platform: bool = false

signal ad_closed
signal ad_failed_to_load

func _ready() -> void:
	# Détecter si on est sur mobile
	is_mobile_platform = OS.get_name() == "Android" or OS.get_name() == "iOS"
	_initialize_admob()

func _initialize_admob() -> void:
	# Vérifier si le plugin AdMob est disponible
	if Engine.has_singleton("AdMob"):
		admob_singleton = Engine.get_singleton("AdMob")
		print("✅ AdMob plugin détecté!")
		
		# Initialiser AdMob
		admob_singleton.initialize()
		is_initialized = true
		
		# Charger la première pub
		_load_interstitial()
	else:
		if is_mobile_platform:
			print("⚠️ AdMob plugin non trouvé sur mobile - Vérifier l'installation")
		else:
			print("ℹ️ Mode développement PC - AdMob fonctionne uniquement sur Android/iOS")
		is_initialized = false

func _load_interstitial() -> void:
	if not is_initialized or admob_singleton == null:
		return
	
	print("📱 Chargement de la publicité interstitielle...")
	admob_singleton.load_interstitial(INTERSTITIAL_AD_UNIT_ID)
	
	# Connecter les signaux
	if not admob_singleton.is_connected("interstitial_loaded", _on_interstitial_loaded):
		admob_singleton.connect("interstitial_loaded", _on_interstitial_loaded)
	if not admob_singleton.is_connected("interstitial_failed_to_load", _on_interstitial_failed):
		admob_singleton.connect("interstitial_failed_to_load", _on_interstitial_failed)
	if not admob_singleton.is_connected("interstitial_closed", _on_interstitial_closed):
		admob_singleton.connect("interstitial_closed", _on_interstitial_closed)

func show_death_ad() -> void:
	if is_initialized and admob_singleton != null and interstitial_loaded:
		print("🎬 Affichage de la publicité!")
		admob_singleton.show_interstitial()
	else:
		if is_mobile_platform:
			print("⚠️ Impossible d'afficher la pub - Plugin non chargé ou pub non prête")
		else:
			print("💻 Simulation de pub (Mode PC - 2 secondes)")
		# Simuler une pub avec un délai
		await get_tree().create_timer(2.0).timeout
		ad_closed.emit()

func _on_interstitial_loaded() -> void:
	print("✅ Publicité chargée avec succès!")
	interstitial_loaded = true

func _on_interstitial_failed(error: String) -> void:
	print("❌ Échec du chargement de la pub: ", error)
	interstitial_loaded = false
	ad_failed_to_load.emit()
	
	# Réessayer après 5 secondes
	await get_tree().create_timer(5.0).timeout
	_load_interstitial()

func _on_interstitial_closed() -> void:
	print("🔄 Publicité fermée")
	interstitial_loaded = false
	ad_closed.emit()
	
	# Charger la prochaine pub
	_load_interstitial()
