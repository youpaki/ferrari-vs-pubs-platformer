# 📱 Configuration AdMob pour Android

## ⚠️ IMPORTANT

**AdMob fonctionne UNIQUEMENT sur les builds Android/iOS exportés.**
Le plugin n'est PAS disponible dans l'éditeur Godot sur PC/Mac.

## 🎯 Solution rapide : Mode simulation

Le jeu fonctionne actuellement en **mode simulation** :
- ✅ Pas besoin de plugin pour tester sur PC
- ✅ À la mort → Pause de 2 secondes simulant une pub
- ✅ Le jeu reste jouable et testable

## 📥 Installation du plugin pour Android (Export)

### Méthode 1 : Téléchargement manuel (Recommandé)

1. **Télécharger le plugin AdMob pour Godot 4.5** :
   - Aller sur : https://github.com/Poing-Studios/godot-admob-android/releases
   - Chercher : `poing-godot-admob-android-v4.*.zip` compatible avec Godot 4.5
   - Télécharger le fichier ZIP

2. **Extraire dans le projet** :
   ```bash
   # Créer le dossier plugins
   mkdir -p android/plugins
   
   # Extraire le contenu du ZIP téléchargé
   unzip poing-godot-admob-android-v4.*.zip -d android/plugins/
   ```

3. **Structure attendue** :
   ```
   android/
   └── plugins/
       └── admob/
           ├── AdMob.gdap
           ├── AdMob.aar
           └── ... (autres fichiers)
   ```

### Méthode 2 : Plugin Godot AdMob (Alternative)

1. Installer le plugin depuis l'Asset Library de Godot :
   - Dans Godot : **AssetLib** → Chercher "AdMob"
   - Installer "Godot AdMob Plugin"

2. Utiliser le Download Manager :
   - **Tools** → **AdMob Download Manager**
   - Sélectionner **Android** → **Latest Version**

## ✅ Vérification de l'installation

### Dans l'éditeur Godot :

1. **Projet** → **Export** → **Android**
2. Vérifier dans **Options** → **Plugins** :
   - ☑️ AdMob doit être coché
3. Si absent → Réinstaller le plugin

### Test avec logs :

Quand vous lancez le jeu :

**Sans plugin (PC)** :
```
ℹ️ Mode développement PC - AdMob fonctionne uniquement sur Android/iOS
💻 Simulation de pub (Mode PC - 2 secondes)
```

**Avec plugin (Android)** :
```
✅ AdMob plugin détecté!
📱 Chargement de la publicité interstitielle...
✅ Publicité chargée avec succès!
🎬 Affichage de la publicité!
```

## 🔧 Configuration des IDs

### IDs de test (actuels) :

```gdscript
# scripts/admob_manager.gd
const INTERSTITIAL_AD_UNIT_ID = "ca-app-pub-3940256099942544/1033173712"
```

Ces IDs Google affichent des pubs de test sans risque.

### IDs de production :

1. Créer un compte sur [AdMob](https://admob.google.com)
2. Créer une application Android
3. Créer une unité publicitaire "Interstitielle"
4. Copier les IDs :
   - **App ID** : `ca-app-pub-XXXXXXXXXX~YYYYYYYYYY`
   - **Unit ID** : `ca-app-pub-XXXXXXXXXX/ZZZZZZZZZZ`

5. Modifier `android/build/AndroidManifest.xml` :
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-VOTRE-APP-ID"/>
```

6. Modifier `scripts/admob_manager.gd` :
```gdscript
const INTERSTITIAL_AD_UNIT_ID = "ca-app-pub-VOTRE-UNIT-ID"
```

## 🚀 Export Android avec AdMob

1. **Activer Custom Build** :
   - **Projet** → **Export** → **Android**
   - ☑️ Cocher "Use Custom Build"

2. **Activer le plugin** :
   - Dans les options Android
   - ☑️ Cocher "AdMob"

3. **Configurer la signature** :
   - Créer un keystore pour signer l'APK
   - Remplir les champs de signature

4. **Exporter** :
   - Cliquer sur "Export Project"
   - Sauvegarder : `build/ferrari-vs-pubs.apk`

## 🎮 Test sur appareil

```bash
# Installer via ADB
adb install build/ferrari-vs-pubs.apk

# Voir les logs en temps réel
adb logcat | grep -i admob
```

## 🐛 Dépannage

### "AdMob plugin non trouvé sur mobile"

**Solutions** :
1. Vérifier que le plugin est dans `android/plugins/`
2. Vérifier que "AdMob" est coché dans Export
3. Reconstruire le projet avec "Clean Build"

### "Pub ne s'affiche pas"

**Vérifications** :
1. App ID correct dans AndroidManifest.xml ?
2. Connexion Internet active ?
3. Attendre 30 secondes pour le chargement initial
4. Vérifier les logs : `adb logcat | grep AdMob`

### "Plugin fonctionne sur Android mais pas dans l'éditeur"

**C'est normal !** AdMob ne fonctionne que sur mobile.
Le mode simulation est automatique sur PC.

## 📚 Ressources

- [Documentation AdMob](https://developers.google.com/admob)
- [Plugin Godot AdMob](https://github.com/Poing-Studios/godot-admob-android)
- [Export Android Godot](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)

## ✅ Checklist finale

- [ ] Plugin téléchargé et extrait dans `android/plugins/`
- [ ] AndroidManifest.xml configuré avec App ID
- [ ] Export Android configuré avec "Use Custom Build"
- [ ] Plugin "AdMob" coché dans les options d'export
- [ ] APK exporté et signé
- [ ] Testé sur appareil Android réel

---

💡 **Astuce** : Pour tester rapidement, utilisez le mode simulation sur PC.
Les vraies pubs AdMob ne sont nécessaires que pour la version finale Android.
