# 🎮 FERRARI vs PUBS - Platformer avec AdMob

## 📱 Installation du plugin AdMob

### Option 1 : Plugin Poing Studios (Recommandé)
1. Téléchargez le plugin : https://github.com/Poing-Studios/godot-admob-android
2. Décompressez dans `android/plugins/`
3. Dans Godot : Projet → Export → Android → Plugins → Cochez "AdMob"

### Option 2 : Plugin GodotAdMob
```bash
# Cloner le repo
cd /Users/seoo/tarace-les-con/addons
git clone https://github.com/Poing-Studios/Godot-AdMob-Android-iOS.git admob
```

### Configuration AdMob

1. **Créer un compte AdMob** : https://admob.google.com
2. **Créer une app** dans la console AdMob
3. **Obtenir vos IDs** :
   - App ID : `ca-app-pub-XXXXXXXXXX~YYYYYYYYYY`
   - Interstitial Unit ID : `ca-app-pub-XXXXXXXXXX/YYYYYYYYYY`

4. **Modifier `scripts/admob_manager.gd`** :
```gdscript
# Remplacer les IDs de test par vos vrais IDs
const INTERSTITIAL_AD_UNIT_ID = "ca-app-pub-VOTRE-ID-ICI/YYYYYY"
```

5. **Ajouter dans `project.godot`** :
```ini
[android]
modules="org.godotengine.godot.AdMob"

[application]
config/android_app_id="ca-app-pub-XXXXXXXXXX~YYYYYYYYYY"
```

6. **Fichier `android/build/AndroidManifest.xml`** :
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXX~YYYYYYYYYY"/>
```

## 🎯 Fonctionnement

- Le jeu fonctionne **SANS** AdMob installé (mode simulation)
- Quand le joueur meurt → Message d'avertissement
- **Avec AdMob** : Vraie pub interstitielle s'affiche
- **Sans AdMob** : Délai de 2 secondes simulé
- Après la pub → Écran Game Over

## 🚀 Build Android

```bash
# Dans Godot
Projet → Export → Android
- Installer Android SDK
- Configurer les templates
- Exporter APK
```

## ✅ Test en mode développement

Le jeu utilise des **IDs de test Google** par défaut :
- Interstitial : `ca-app-pub-3940256099942544/1033173712`

Ces IDs affichent des pubs de test sans risque de ban.

## 🎮 Gameplay

- **Flèches** : Bouger gauche/droite
- **ESPACE** : Sauter
- **Objectif** : Éviter les pubs ennemies
- **Ennemis** : 4 types (PopUp, Banner, Malware, Clickbait)
- **Santé** : 3 vies
- **Mort** → Pub AdMob s'affiche !

## 🔧 Debug

Console affiche :
- ✅ AdMob plugin détecté
- 📱 Chargement de la publicité
- 🎬 Affichage de la publicité
- ⚠️ Mode simulation (si plugin absent)
