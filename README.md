# 🥋 Orukam

**Orukam** est une application gratuite qui permet d'organiser la **répartition des arbitres et des commissaires sur les tapis** lors d'une compétition (judo, karaté, ou tout autre sport utilisant des tapis/aires de combat).

---

## 📋 À quoi sert cette application ?

Quand vous organisez une compétition de sport de combat, vous devez répartir des **arbitres** et des **commissaires** sur chaque **tapis** (aire de combat). Orukam vous aide à :

- 🏷️ **Nommer votre compétition** (ex : « Tournoi de Paris 2026 »)
- ➕ **Créer des tapis** (Tapis 1, Tapis 2, etc.)
- 👤 **Ajouter des arbitres et des commissaires** sur chaque tapis
- 👑 **Désigner des responsables** (un responsable arbitre et un responsable commissaire au niveau global, et un par tapis)
- 🔄 **Déplacer les personnes d'un tapis à l'autre** par simple glisser-déposer (drag & drop)
- 🗑️ **Supprimer** des personnes, des tapis, ou remettre à zéro toute la compétition

Toutes les données sont **sauvegardées automatiquement** sur votre appareil. Vous n'avez pas besoin de connexion Internet.

---

## 🖥️ Sur quels appareils ça fonctionne ?

Orukam fonctionne sur :

- **Windows** (PC)
- **macOS** (Mac)
- **Linux**
- **Android** (téléphone et tablette)
- **iOS** (iPhone et iPad)
- **Navigateur web**

---

## 📥 Comment installer et utiliser l'application ?

### Option 1 : Télécharger une version prête à l'emploi (recommandé)

> Si une version compilée est disponible (fichier `.apk` pour Android, `.exe` pour Windows, etc.), il vous suffit de la télécharger et de l'installer comme n'importe quelle application.
>
> Consultez la section **[Releases](../../releases)** de ce dépôt pour voir les versions disponibles.

### Option 2 : Compiler l'application vous-même (utilisateurs avancés)

Si aucune version compilée n'est disponible, vous pouvez construire l'application vous-même. Voici les étapes :

1. **Installer Flutter** : suivez le guide officiel sur [flutter.dev/get-started](https://docs.flutter.dev/get-started/install)
2. **Télécharger le code source** :
   ```bash
   git clone <url-du-dépôt>
   cd orukam
   ```
3. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```
4. **Lancer l'application** :
   ```bash
   flutter run
   ```
   Flutter vous proposera de choisir l'appareil cible (navigateur web, Windows, Android, etc.).

---

## 🚀 Comment utiliser l'application ?

### 1. Nommer la compétition
Au lancement, la compétition s'appelle « Ma Compétition ». Cliquez sur le nom en haut de l'écran (à côté de l'icône ✏️) pour le modifier.

### 2. Ajouter des tapis
Appuyez sur le bouton **« Ajouter Tapis »** en bas à droite. Donnez un nom au tapis (ex : « Tapis 1 ») et validez. Vous pouvez ajouter autant de tapis que nécessaire.

### 3. Définir les responsables généraux
En haut de l'écran, deux zones permettent de définir :
- Le **Responsable Arbitre** (en bleu)
- Le **Responsable Commissaire** (en rouge)

Cliquez sur **« Définir »** pour saisir le nom du responsable.

### 4. Ajouter des arbitres et commissaires sur un tapis
Sur chaque carte de tapis, vous trouverez deux sections :
- **Arbitres** (en bleu) : cliquez sur l'icône 👤+ pour ajouter un arbitre
- **Commissaires** (en rouge) : cliquez sur l'icône 👤+ pour ajouter un commissaire

Vous pouvez aussi définir un **responsable** par section en cliquant sur « Définir responsable ».

### 5. Déplacer des personnes (glisser-déposer)
Vous pouvez **glisser** n'importe quel nom et le **déposer** sur un autre tapis ou sur la zone des responsables généraux pour le réaffecter.

### 6. Supprimer
- Pour supprimer une personne : cliquez sur l'icône ❌ à côté de son nom
- Pour supprimer un tapis : cliquez sur l'icône 🗑️ sur la carte du tapis
- Pour tout effacer : cliquez sur l'icône 🗑️ rouge dans la barre du haut et confirmez

---

## 💾 Données

Les données sont stockées **localement** sur votre appareil dans une base de données SQLite. Rien n'est envoyé sur Internet. Si vous désinstallez l'application, les données seront perdues.

---

## 🛠️ Informations techniques

- **Langage** : Dart
- **Framework** : Flutter
- **Base de données** : SQLite (via `sqflite`)
- **Gestion d'état** : Provider
- **Version** : 1.0.0
