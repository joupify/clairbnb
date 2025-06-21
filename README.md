# Clairbnb 🏡  
**Plateforme de location de logements inspirée d'Airbnb**  
Projet personnel développé en Ruby on Rails

---

## 📍 Description

Clairbnb est une application web de location de logements courte durée, qui permet aux utilisateurs de réserver ou de proposer un hébergement. Inspirée de la plateforme Airbnb, l’application propose une expérience utilisateur fluide, sécurisée et responsive.

Ce projet a été conçu pour renforcer mes compétences full-stack en Ruby on Rails, notamment autour de la gestion des paiements, des réservations et des notifications en temps réel.

---

## 🚀 Fonctionnalités principales

- 🔐 **Authentification sécurisée** (via Devise)
- 📆 **Réservation de logements**
  - Sélection de dates disponibles
  - Calcul automatique du prix
- 💳 **Paiement sécurisé via Stripe**
- 🔔 **Notifications en temps réel**
  - Confirmation de réservation
  - Notifications pour l'hôte et le voyageur
- 🏠 **Création et gestion d’annonces**
  - Ajout de photos (Active Storage)
  - Description, prix, localisation
- 📱 **Interface utilisateur responsive**

---

## 🛠️ Technologies utilisées

| Outil / Lib | Usage |
|-------------|-------|
| **Ruby on Rails 7** | Framework backend principal |
| **PostgreSQL** | Base de données relationnelle |
| **Devise** | Authentification |
| **Stripe** | Paiement sécurisé |
| **Stimulus.js & Turbo (Hotwire)** | Interactions frontend réactives |
| **Active Storage** | Stockage des images |
| **Heroku** | Déploiement |
| **RSpec / Capybara** | Tests automatisés |

---

## 📸 Aperçu (Screenshots)

*captures d’écran de l’interface utilisateur (accueil, fiche logement, paiement, etc.)*

---

## 📂 Installation & Lancement

### 1. Cloner le repo

```bash
git clone https://github.com/joupify/claibnb.git
cd clairbnb
```

### 2. Installer les dépendances

```bash
bundle install
yarn install
```

### 3. Configuration de la base de données

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Lancer le serveur

```bash
rails s
```

### 5. Accéder à l’application

[http://localhost:3000](http://localhost:3000)

---

## ✅ Objectifs pédagogiques atteints

- Développement full-stack complet avec Ruby on Rails
- Intégration de paiements Stripe et webhooks
- Gestion d’un cycle de réservation de bout en bout
- Messagerie entre utilisateurs
- Mise en place de notifications temps réel (Turbo Streams)
- Déploiement d’une application Rails en production (Heroku)

---

## 📌 Prochaines évolutions (roadmap)

- 🔒 Système de vérification d’identité pour les hôtes
- 🗺️ Intégration de cartes interactives (Mapbox ou Google Maps)
- 📝 Système d’avis et de notation
- 📊 Statistiques pour les hôtes (taux d’occupation, revenus)


## 👩‍💻 Auteur

**Malika Housni**  
Développeuse Full Stack Ruby on Rails  
[Portfolio GitHub](https://github.com/joupify)
