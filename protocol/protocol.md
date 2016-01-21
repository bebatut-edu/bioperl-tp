---
title: Traitement de données génomiques avec Perl Orienté Objet et BioPerl
subtitle: IUT Génie Biologique, Option Bioinformatique (2e année)
date: Février 2016
author: Bérénice Batut
geometry: margin=2.5cm
---

# Introduction

Les séances de TP vont s'organiser autour d'un mini-projet qui vous permettra de 
vous familiariser avec le traitement de séquences en utilisant des classes, des 
références et BioPerl.

## Principe du projet

L'objectif du projet est traiter très simplement un jeu de données métagénomique, 
c'est-à-dire un jeu de données contenant de nombreuses séquences dont on ne 
connait pas l'origine. Les traitements passent un contrôle de la qualité des 
séquences et un essai d'affiliation des séquences à des séquences connues.

Ce projet vous permettra de vous familiariser avec ce type de données pour mieux
les utiliser dans le projet du cours de Métagénomique et d'avoir une vue rapide
de ce qu'il y a derrière les outils de traitement de ce type de données. 

## Organisation

Pour ce projet, vous vous mettrez par binome. Les deux membres du binome doivent
participer au projet, pour les codes mais aussi la rédaction du compte-rendu. 
D'ailleur, il serait bien qu'au moins un des membres du binome amène son 
ordinateur personnel. De plus, la personne qui "code" et la personne qui "rédige"
ne doivent pas être toujours les même.

La note du projet portera sur le compte-rendu, les codes fournis et le suivi des 
instructions (2 points).

## Instructions

L'organisation est importante tout le temps, même en information et en bioinformatique.
En particulier dans un projet bioinformatique, il est important de bien centralisé
à un seul endroit (dossier) tous les fichiers concernant le projet afin de garder 
une trace. De plus, les fichiers au sein de ce dossier doivent être organiser
de façon méthodique afin de faciliter votre travail mais aussi celui de vos 
collaborateur. 

Ainsi, tous les fichiers liés à ce projet sont rassemblés dans un dossier comprenant

- Un dossier `data` pour toutes les données
- Un dossier `results` pour les résultats des analyses (graphiques, fichiers
générés, ...)
- Un dossier `src` pour le script principal (nommé ``) et les modules Perl développés
- Un dossier `doc` pour les notes et en particulier le compte-rendu du TP

Le compte-rendu dans le cadre de ce projet correspond à un "cahier de notes", où
les différentes étapes de l'analyse (graphiques, résultats, échecs, ...). En 
effet, quand on travaille sur un projet, tenir un tel "cahier" permet de garder une
trace de ce qui a été fait, ce qui a marché pour pouvoir expliquer la démarche, 
faciliter la reprise du travail par quelqu'un, ... Dans ce "cahier", vous noterez
les différentes étapes, les grandes lignes des codes, les méthodes particulières
utilisées (et pourquoi), les graphiques, les liens vers les fichiers utiles ainsi
que les sites. Pour faciliter la rédaction, un modèle de cahier en `markdown` doit
être utilisé. Il est disponible sur [bebatut-edu.github.io](http://bebatut-edu.github.io/).

L'organisation et la collaboration passent aussi par le rédaction de codes "propres".
Un code "propre" permet de faciliter la prise en main du code par quelqu'un de 
nouveau, mais aussi par vous dans quelques mois. Ecrire un code "propre" implique 
de suivre quelques règles

- Documenter le code (avec POC en Perl)
- Faire attention à l'indentation
- Ne pas mettre trop de caractères par ligne (généralement, moins de 80)

Deux modèles sont disponibles sur [bebatut-edu.github.io](http://bebatut-edu.github.io/) : 
un modèle pour les classes et un modèle pour les scripts. Ils doivent être utilisé
dans ce projet. Ces modèles intègrent de la documentation qui doit être mise à 
jour régulièrement et visualiser avec `perldoc`. 

Pour visualiser l'enchainement nécessaire des analyses et garder une trace des
paramètres choisis, toutes les commandes utilisées seront exécutées depuis un 
script Perl principal nommé `traitement_donnees.pl`. Cependant, comme toutes les 
étapes ne seront pas à exécuter à chaque fois, il faut penser à mettre des conditions
de test pour les exécutions.

# Récupération et première exploration des données

Les données à utiliser par chaque binôme sont disponibles sur 
[bebatut-edu.github.io](http://bebatut-edu.github.io/). Cependant, pour garder une
trace des données téléchargées, toutes les commandes utilisées pour récupérer et 
transformer les données sont notées dans le script principal.

Quelques pistes pour la récupération des données

- Le téléchargement de données se fait avec la commande `shell` `wget <link>` 
(`<link>` correspondant au lien récupéré en faisant `Clic droit->Copier l'adresse
du lien` dans votre navigateur sur le lien à télécharger)
- Les données doivent être déplacées dans le répertoire `data`
- L'extraction des données avec l'extension `gz` se fait en utilisant la commande 
`gunzip path/to/file`
- L'exécution de commandes systèmes dans Perl se fait en les invoquant avec 
`system "command"`

Nous souhaiterions avoir quelques informations sur le fichier et son contenu (la 
taille, le nombre de ligne dans le fichier, ...). Ces informations doivent être
affichées à l'écran lors de l'exécution du script principal. Pour la taille d'un
fichier, vous devez utiliser la classe 
[`File::stat`](http://perldoc.perl.org/functions/stat.html) avec la méthode `size`,
qui renvoie la taille en octets. Pour le nombre de ligne, vous écrivez une 
méthode `get_line_number` qui ouvre le fichier et lit ligne par ligne jusqu'à la 
fin en comptant les lignes. Vous pouvez vérifier le bon fonctionnement de votre 
méthode en exécutant `wc -l path/to/file` depuis un terminal. 

Le fichier contenant les séquences est au format `fastq`. Chaque séquence est 
ainsi représentée sur 4 lignes. En utilisant la méthode `get_line_number`, on 
souhaiterait obtenir le nombre de séquences dans le fichier, grâce à une méthode 
`get_sequence_number`. 

# Création d'une classe `Sequence`

Pour gérer les séquences contenu dans le fichier de données, nous décidons de 
créer une classe `Sequence`, en s'inspirant de la classe `Bio::Seq`. Ainsi, 
dans un premier temps, les objets `Sequence` ont comme propriétés:

- Sa séquence à proprement parler
- Son identifiant
- Sa longueur

Le constructeur de la classe `Sequence` prend en argument un objet `Bio::Seq` et
extrait les informations utiles pour remplir les propriétés d'un objet `Sequence`.
Vous testerez ce constructeur sur la première séquence du fichier de données
(lue grâce à  `Bio::SeqIO`), en utilisant `Dumper`.

Une classe fonctionne mieux quand elle a des "getters" et des "setters", c'est-à-dire
des méthodes permettant d'accéder aux propriétés pour les récupérer ("getters") 
ou les modifier ("setters"). Vous ajoutez donc à votre classe `Sequence` les 
"getters/setters" nécessaires pour chaque propriété et vous les testez dans
le script principal. Que penser d'un "setter" pour la propriété de longueur?
Quelles sont les différentes possibilités?

# Parcours d'un fichier de séquences

Nous souhaitons maintenant parcourir le fichier avec les séquences et enregistrer
les séquences dans des objets `Sequence`, qui seront stockés dans un tableau.

Dans un premier temps, nous aimerions savoir si le nombre de séquences calculé
précédemment correspond bien au nombre de séquences dans le fichier. Pour cela,
vous écrivez une méthode `get_real_sequence_number` qui prend en argument le chemin
vers le fichier, le parcours avec un objet `Bio::SeqIO` en comptant le nombre de
séquences (dans le script principal).

Dans un second temps, nous pouvons construire des objets `Sequence` pour chaque
séquence dans le fichier de séquences et enregistre la référence de cet objet dans
un tableau. Ainsi, le tableau contiendra autant de cases qu'il y a de séquences. 
Pour cela, vous écrivez une méthode `fill_sequence_tabular` (dans le script
principal) qui prend en argument le chemin vers le fichier. Cette méthode initialise
un tableau vide, parcours le fichier avec un objet `Bio::SeqIO` et pour chaque
séquence, créé un objet `Sequence` et enregistre cet objet dans le tableau. La
méthode renvoie ensuite le tableau. 

Le fichier est au format `fastq` et contient donc, pour chaque séquence, sa 
séquence nucléotidique mais aussi la séquence des scores de qualité pour chaque
nucléotide. Jusqu'à présent, nous avons considéré les séquences comme des objets
`Bio::Seq`. Or ce type d'objet ne peut contenir de score de qualité. Afin de 
pouvoir récupérer correctement la séquence des scores de qualité, il faut déjà 
vérifier quel type d'objet est généré pour chaque séquence par `Bio::SeqIO`. 
Pour cela, vous récupérez la première séquence du fichier avec  `Bio::SeqIO` et
vous affichez l'objet avec `Dumper`. Comment récupérer la séquence des scores de
qualité? Sous quel type de données et pourquoi ce type?

Pour conserver le score qualité, vous complétez la classe `Sequence` en ajoutant
une nouvelle propriété pour le score de qualité (penser au "getter").

# Contrôle de la qualité des séquences

## Contrôle de la longueur des séquences

## Contrôle des scores de qualité

# Assignation des séquences à des séquences connues 

