# 🚀 Installation et Configuration

## 📋 Prérequis

- **Godot Engine 4.5+**
- **Android SDK** (pour export mobile)
- **Plugin AdMob** (déjà inclus dans `addons/admob/`)

## 🎮 Lancer le jeu en développement

1. **Ouvrir le projet dans Godot**
   ```bash
   # Lancer Godot et ouvrir le dossier du projet
   open -a Godot /Users/seoo/tarace-les-con/project.godot
   ```

2. **Tester sur PC**
   - Appuyez sur **F5** ou cliquez sur ▶️
   - Contrôles : **Flèches** (mouvement) + **ESPACE** (saut)

## 📱 Build Android

### 1️⃣ Activer le Build Template

Dans Godot :
1. **Projet** → **Installer les templates de build Android**
2. **Projet** → **Export** → **Ajouter...** → **Android**

### 2️⃣ Configuration AdMob

Le fichier `android/build/AndroidManifest.xml` est déjà configuré avec :
- **App ID de test Google** : `ca-app-pub-3940256099942544~3347511713`
- **Permissions** : Internet, Network State

### 3️⃣ Export APK

1. Dans Godot : **Projet** → **Export**
2. Sélectionnez **Android**
3. Cliquez sur **Exporter le projet**
4. Sauvegardez : `build/ferrari-vs-pubs.apk`

### 4️⃣ Installer sur appareil

```bash
# Via ADB
adb install build/ferrari-vs-pubs.apk

# Ou transférer l'APK et installer manuellement
```

## 🔑 Utiliser vos propres IDs AdMob (Production)

1. **Créer un compte** : https://admob.google.com

2. **Créer une app** et obtenir :
   - App ID : `ca-app-pub-XXXXXXXXXX~YYYYYYYYYY`
   - Interstitial Unit ID : `ca-app-pub-XXXXXXXXXX/ZZZZZZZZZZ`

3. **Modifier `android/build/AndroidManifest.xml`** :
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-VOTRE-APP-ID-ICI"/>
   ```

4. **Modifier `scripts/admob_manager.gd`** :
   ```gdscript
   const INTERSTITIAL_AD_UNIT_ID = "ca-app-pub-VOTRE-UNIT-ID-ICI"
   ```

## 🎯 Fonctionnalités

### Mode Développement (sans plugin)
- Le jeu fonctionne normalement
- À la mort → Simulation de 2 secondes
- Message dans console : `⚠️ Pub simulée`

### Mode Production (avec plugin)
- Le jeu utilise le plugin AdMob
- À la mort → **Vraie pub interstitielle**
- Message dans console : `🎬 Affichage de la publicité!`

## 🐛 Debug

### Vérifier les logs
```gdscript
# Dans Godot Output :
✅ AdMob plugin détecté!       # Plugin trouvé
📱 Chargement de la publicité  # Pub en cours de chargement
✅ Publicité chargée           # Pub prête
🎬 Affichage de la publicité!  # Pub affichée
🔄 Publicité fermée            # Retour au jeu
```

### Problèmes courants

**"AdMob plugin non trouvé"**
- Normal en mode développement PC
- Le plugin fonctionne uniquement sur Android build

**"Pub ne s'affiche pas"**
- Vérifier l'App ID dans AndroidManifest.xml
- Vérifier les permissions Internet
- Attendre le chargement de la pub

## 📚 Documentation

- [README AdMob](README_ADMOB.md) - Configuration détaillée
- [Plugin AdMob](addons/admob/README.md) - Doc du plugin
- [Godot Android Export](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)

## 🎮 Gameplay

- **Objectif** : Survivre le plus longtemps possible
- **Ennemis** : 4 types de pubs (PopUp, Banner, Malware, Clickbait)
- **Santé** : 3 vies (❤️❤️❤️)
- **Mort** : Pub AdMob s'affiche → Game Over

Bon jeu ! 🚗💨
