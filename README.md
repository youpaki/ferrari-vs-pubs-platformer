# 🎮 Ferrari vs Pubs - Platformer 2D

<p align="center">
  <img src="https://img.shields.io/badge/Godot-4.5-blue?logo=godot-engine" alt="Godot 4.5"/>
  <img src="https://img.shields.io/badge/Platform-Android-green?logo=android" alt="Android"/>
  <img src="https://img.shields.io/badge/AdMob-Integrated-red?logo=google" alt="AdMob"/>
  <img src="https://img.shields.io/github/license/youpaki/ferrari-vs-pubs-platformer" alt="License"/>
</p>

<p align="center">
  Un platformer 2D où vous contrôlez une Ferrari pour esquiver des publicités ennemies malicieuses.<br/>
  <strong>💀 Si vous mourez, une VRAIE publicité AdMob s'affiche ! 💀</strong>
</p>

---

## ✨ Fonctionnalités

- 🚗 **Joueur Ferrari** avec physique platformer réaliste
- 👾 **4 types d'ennemis publicitaires** :
  - 🎯 **PopUp** - Publicités pop-up classiques
  - 📰 **Banner** - Bannières promotionnelles
  - ☠️ **Malware** - Virus dangereux
  - 🎣 **Clickbait** - Pubs clickbait trompeuses
- ❤️ **Système de vies** (3 cœurs)
- 🏗️ **Niveau multi-plateformes** généré par code
- 📱 **AdMob intégré** - Vraies pubs à la mort du joueur
- 🎨 **Graphismes générés** par code (pas de dépendances)
- 🎮 **Contrôles** : Flèches + ESPACE

## 🎯 Gameplay

1. Déplacez la Ferrari avec les **flèches directionnelles**
2. Sautez avec **ESPACE**
3. Évitez les publicités ennemies qui patrouillent
4. Survivez le plus longtemps possible
5. **À la mort** → Une vraie pub AdMob s'affiche ! ��

## 🚀 Installation

```bash
# Cloner le repository
git clone https://github.com/youpaki/ferrari-vs-pubs-platformer.git
cd ferrari-vs-pubs-platformer

# Ouvrir dans Godot 4.5+
# Fichier → Ouvrir un projet → Sélectionner le dossier
```

Pour plus de détails : [INSTALLATION.md](INSTALLATION.md)

## 📱 Build Android

Le jeu est configuré pour Android avec AdMob :

1. **Configuration automatique** : AndroidManifest.xml inclus
2. **IDs de test Google** déjà configurés
3. **Permissions** : Internet, Network State

```bash
# Dans Godot
Projet → Export → Android → Exporter le projet
```

Consultez [README_ADMOB.md](README_ADMOB.md) pour la configuration complète.

## 🔧 Architecture du projet

```
ferrari-vs-pubs-platformer/
├── scenes/
│   ├── player.tscn          # Scène du joueur Ferrari
│   └── ad_enemy.tscn        # Scène des ennemis pubs
├── scripts/
│   ├── player.gd            # Logique platformer
│   ├── ad_enemy.gd          # IA ennemis + patrouille
│   ├── game_manager.gd      # Gestionnaire de jeu
│   └── admob_manager.gd     # Intégration AdMob
├── addons/
│   └── admob/               # Plugin AdMob officiel
├── android/
│   └── build/
│       └── AndroidManifest.xml  # Config Android + AdMob
└── node_2d.tscn            # Scène principale
```

## 🎨 Screenshots

> TODO: Ajouter des captures d'écran du gameplay

## 📋 Prérequis

- **Godot Engine** 4.5 ou supérieur
- **Android SDK** (pour build mobile)
- **Compte AdMob** (optionnel, IDs de test fournis)

## 🔑 Configuration AdMob (Production)

Pour utiliser vos propres publicités :

1. Créer un compte sur [AdMob](https://admob.google.com)
2. Créer une application
3. Obtenir votre App ID et Unit ID
4. Modifier `android/build/AndroidManifest.xml`
5. Modifier `scripts/admob_manager.gd`

Guide complet : [README_ADMOB.md](README_ADMOB.md)

## 🎮 Contrôles

| Action | Touche PC | Mobile |
|--------|-----------|--------|
| Déplacer gauche | ⬅️ Flèche gauche | - |
| Déplacer droite | ➡️ Flèche droite | - |
| Sauter | ⌨️ ESPACE | - |

## 🐛 Debug

Le jeu affiche des logs dans la console Godot :

```
✅ AdMob plugin détecté!
📱 Chargement de la publicité interstitielle...
✅ Publicité chargée avec succès!
🎬 Affichage de la publicité!
🔄 Publicité fermée
```

Sans le plugin (mode PC) :
```
⚠️ AdMob plugin non trouvé - Mode simulation
⚠️ Pub simulée (plugin non installé)
```

## 📄 Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'feat: Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📚 Ressources

- [Documentation Godot](https://docs.godotengine.org/)
- [AdMob Documentation](https://developers.google.com/admob)
- [Plugin AdMob pour Godot](https://github.com/Poing-Studios/godot-admob-android)

## 👤 Auteur

**youpaki**

- GitHub: [@youpaki](https://github.com/youpaki)

## ⭐ Support

Si vous aimez ce projet, n'hésitez pas à lui donner une ⭐ sur GitHub !

---

<p align="center">
  Fait avec ❤️ et Godot Engine
</p>
