# Dwish 

## Présentation

[Dwish] (<https://dwish.fr/fr>) offre un service de sandwicherie et de traiteur dans le 6ème arrondissement de Marseille. Vous pouvez y retrouver de vrais et bons sandwichs, des desserts gourmands et des produits d'épicerie fine, le tout dans une véritable démarche artisanale, locale et éco-responsable.

## Objectif

Aujourd'hui le restaurant possède seulement un site vitrine. L'objectif est de créer un nouveau site avec une fonctionnalité de click & collect pour permettre aux clients de récupérer leurs commandes de repas.

## Parcours utilisateur

L'utilisateur pourra créer son compte en ligne et passer commande et payer en ligne pour récupérer son délicieux dwish en magasin. Il pourra aussi commander des prestations de traiteur pour de plus gros événements.

##  Aspects techniques


### Liste des fonctionnalités

- un menu de navigation
- les pages statiques de l'ancien site pour présenter le restaurant
- un compte utilisateur (nom, prénom, email, mot de passe, historique des commandes)
- un catalogue des produits à la vente (sandwiches, salades, desserts, boissons)
- un panier pour passer des commandes
- le paiement en ligne des commandes à emporter
- un système d'emails automatiques pour confirmer la création d'un compte utilisateur, le paiement en ligne, ...

### Base de données

Création d'une base de données Postgresql avec les tables suivantes

- Users
- Orders
- Products
- Checkouts
- ...

### Front

- Reprise du CSS existant de l'ancien site. 
- Utilisation de Javascript pour le menu glissant principal

### Backend

- Utilisation de l'API Stripe
- Utilisation de l'API Zelty pour l'interface avec la caisse enregistreuse ( à voir)
- Utilisation de Sendgrid ou Mailjet pour 

### Compétences techniques recherchées

- Postgresql
- Javascript/HTML/CSS
- Ruby on Rails
- Scrum
- Maîtrise de l'API Stripe
- Maîtrise de l'API Sendgrid ou Mailjet

## MVP

- Affichage des pages statiques existantes
- Créer un compte utilisateur
- Affichage du catalogue des produits
- Panneau d'administration

## Version 1

- Ajouter des produits dans un panier
- Valider son panier et payer en ligne
- Automatiser l'envoi des emails
- Panneau d'administration

## Mentor

Benoit Figea