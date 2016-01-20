TP de Perl orienté objet et BioPerl
===================================

4 séances de 2h de TP

# Objectif

- Ecriture et utilisation d'une classe
- Ecriture et utilisation de référence
- Utilisation de BioPerl
- Familiariser avec le traitement de données 

# Idées

- Prendre un jeu de données métagénomique
- Créer une classe `Sequence` similaire à la classe `Bio::Seq` mais pour plus
d'informations (qualité, traitement qualité faits, ...)
- Création d'un tableau qui enregistre tous les objets `Sequence` créés à partir
du fichier de séquence
- Prétraitement du jeux de données (contrôle qualité)

# Organisation (comme pour un projet) (2 points)

- Importance de l'organisation (prise en compte dans la note finale) (0.5 points)
    - Création d'un dossier avec
        - 1 dossier `data` pour les données
        - 1 dossier `results` pour les résultats avec les graphiques et autres
        - 1 dossier `src` pour les scripts et les modules Perl et autres scripts
            - 1 script principal `script.pl` avec l'enchainement des  
        - 1 dossier `doc` pour les notes
        - 1 fichier `README` qui explique l'objectif du projet, les auteurs, ...
- Utilisation d'un "notebook" (principe d'un compte-rendu en TP) avec un template 
(0.5 points)
    - Expliquer l'utilité en bioinformatique (traçabilité, pour expliquer les 
    étapes des analyses, ce qui a marché et ce qui n'a pas marché, faciliter la
    reprise du travail par quelqu'un  d'autres, ...) 
    - Expliquer le markdown dans le template
    - Expliquer comment l'utiliser
        - Noter pour chaque étape ce qui est fait et pourquoi 
        - Ce n'est pas un script donc pas besoin de noter tout le code mais les 
        grandes lignes ou les méthodes particulières utilisées
        - Intégrer les graphiques générés
        - Intégrer les liens vers les fichiers utiles mais aussi les sites 
- Utilisation d'un template pour les fichiers de scripts (0.5 points)
    - Expliquer le template des scripts Perl et des classes
    - Importance de la documentation
        - Vérifier la documentation avec `perldoc` 
    - Quelques règles à respecter
        - Faire attention à l'indentation
        - Ne pas mettre plus de 80 caractères par ligne 
- Utilisation d'un template `README` (0.5 points)
    - Expliquer l'importance du fichier `README` dans un projet
        - Beaucoup utiliser en informatique
        - Explication rapide du contenu du dossier (objectif, comment utiliser, ...)
        - Explication rapide de la structure (dossiers, ...)
        - Auteurs

# Données

Données issues d'un jeu de données métagénomique pour l'
[étude du microbiote intestinal de jumeaux obèses et maigres](http://dx.doi.org/10.1038/nature07540)

Données disponibles pour chaque binome sur [http://bebatut-edu.github.io/](http://bebatut-edu.github.io/)

# Principe

- Récupération des données
    - Récupération des données avec `wget`
    - Décompression des données avec `tar`
- Création d'une classe `Sequence` dans un fichier `Sequence.pm`
    - Constructeur
        - Séquence
        - Qualité
        - Longueur
        - Identifiant
        - Qualité moyenne 
        - Conserver 
    - Méthodes
        - Getters
        - Setters 
    - Tests?
- Création d'un tableau vide 
    - Nombre d'éléments? Accessible depuis l'objet `Bio::SeqIO`? 
- Parcours du fichier
    - Création d'un objet `Sequence` pour chaque séquence du fichier
    - Ajout de la référence vers cet objet dans le tableau
- Création d'une méthode qui renvoi l'objet `Sequence` correspondant à un 
identifiant donné
- Contrôle qualité
    - Génération des graphes de qualité
        - 
    - Parcours des séquences
        - Récupération de la qualité moyenne 
            - Changement du statut `Conserver` si la qualité moyenne inférieure 
            à un seuil
        - Coupure des séquences à conserver à la longueur déterminée avec les 
        graphiques
        - Ecriture des séquences à conserver et coupées dans un fichier 
- Recherche de similarité et interrogation de bases de données
    - Création de la base de données
    - Recherche de similarité entre la base de données et les séquences conservées
    - Ajout dans le constructeur de `Sequence` une propriété avec un tableau 
    vide `id_similaire`
    - Parcours du rapport généré
        - Pour chaque résultats, pour chaque hits, pour chaque hsp
            - Récupération de l'identifiant de la séquence et de la séquence 
            correspondante
            - Récupération du nom de la séquence dans la base de données par
            interrogation de la base de données avec l'identifiant dans le 
            rapport de recherche de similarité
            - Ajout dans le tableau `id_similaire` de l'objet `Sequence` du nom
            de la séquence similaire


