

Voici le journal de groupe où nous avançons. Ce journal a été crée en retard je vous invite à regarder nos journal respectifs si vous voulez voir
Ici, nous nous consacrerons à l'anvancée du site web. Tous les scripts ayant été finis.

Nous avons fait beaucoup de recherches sur les designs des pages webs aujourd'hui et ces dernières se ressemblent et ont des codes que nous respecteront.

--- 01/12/23 ---
Conception du site :

La première chose à faire a été d'élaborer la conception du site comment on l'imaginait. Vu que notre mot est "devoir" le design d'un cahier de devoir pour notre page d'index nous a paru être une évidence.
Nous allons concevoir un header et un footer puisque cela est une norme sur tous les sites web aujourd'hui.

Les informations que nous mettrons dans le header :
- une icone (moyen de retourner sur la page d'index),
- un onglet méthode (qui expliquera pourquoi ce mot, les langues sur lesquelles nous allons travailler), notre hypothèse, l'étymologie du mot...
- un onglet analyse dans lequels on mettra notre analyse itrameur
- Le logo GitHub qui permettra d'accéder à cet endroit

Les informations que nous mettrons dans le footer :
- Qui nous sommes (afin de détailler et donner des informations sur nous)
- Une documentation
- Des logos qui permettent de nous contacter sur facebook, twitter, par mail (cela sera fictif et les redirections seront sur les sites mais nous n'avons pas de page de réseaux social à proprement parlée à donner)
- Gestion des cookies (cela sera fictif, mais l'aspect gestion des cookies est important de nos jours)
- Notre signature

---------------Baptiste (j'ai quelques connaissances sur le developpement de site web et ai déjà eu l'occasion d'en développer certains je vais utiliser mes connaissances pour faire avancer le groupe rapidement)------------------

Très peu de frameworks ont été utilisé car j'ai appris à utilisé le css sur mes sites. Nous nous sommes servis de Bulma (pour nos tableaux).

Toutes les pages html sont rangés dans le dossier vue, il y'a le dossier PPE dans lequel on retrouve toutes nos aspirations, nos concordanciers, le dossier css dans lequels toutes les pages css se trouvent.

--- 13/12/23 ---
PAGE INDEX :

- Le premier obstacle auquel nous avons été confronté est l'incorporation du header et du footer dans toutes les pages. En effet lorsque, je développais des sites j'avais pour habitude de coder mon header et mon footer dans un fichier
php ou encore js et de l'appeler dans mes pages html. Malheureusement, je n'ai pas reussi à reproduire cette technique car il semblerait que l'hebergeur github ne prennent pas en charge les fichiers js où php incorporés dans un html.

Le header et le footer n'ont pas posé de difficultés particulière à coder mais du coup ils sont incorporés sur toutes les pages html de façon très rébarbative et pas très agréable à lire.
J'ai découvert également que lorsque l'on écrivait un lien href il était possible de lui mettre l'attribut target='_blank' afin d'ouvrir un nouvel onglet lorsque l'utilisateur clique dessus.
Petit détail également à l'aide d'un href mailto il est possible d'envoyer automatiquement un mail à l'adresse que nous avons renseigné dans le mailto <a href="mailto:projetPPE2023BMK@gmail.com">.


- Autre problème auquel nous avons été confronté est a l'affiche de l'image en effet, nous avions dit que nous voulions un cahier sur notre page index, nous avons eu une autre idée entre temps. Nous voulions que ce cahier soit sur une table.
Il a donc fallu prendre l'image d'une table et superposer le cahier dessus. Jusque là rien de bien méchant puisque nous avons fait en sorte que notre image de cahier soit sur un fond transparent.
Le problème et vous verrez que c'est une problème récurrent est le responsive design. En effet en fonction des différents écran ces images se superposent bizzarement. Ce problème sera traité grâce à des media queries, mais je pense
qu'il aurait été plus facile d'utiliser des frameworks pour ne pas avoir ces problèmes de responsives design.

- Pour les différents logos nous avons juste utiliser ceux que proposer le site FontAwesome :    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">.

- Une nouvelle idée nous aient venue. Nous voulions travaillé plus l'aspect linguistique de notre site en permettant à l'utilisateur que la page soit traduite en fonction de ses préférences. Nous avons donc fait une tentative
d'inclure l'API google traduction via un script js. Cela n'a malheureusement pas fonctionné avec un peu plus de temps nous aurions pu travailler cet aspect.


--- 26/12/23 ---
PAGE ANALYSE :

Cette page est probablement celle qui nous a posé le plus de problèmes.

En effet, pour rendre notre page interactive nous avons voulu mettre des key frames afin de faire des animations.
La partie la plus dure à géré a été

--- 26/12/23 ---
Qui sommes nous : (page dans le footer), une des pages dont nous sommes les plus fiers. Nous avons importé Leaflet (afin d'afficher une map interactive). Je ne sais pas pourquoi il y'a des losanges et que l'affiche se fait sur des ronds, j'ai eu beau regarder la documentation de leaflet je n'ai pas trouvé pourquoi nous avions ce problème d'affichage. J'ai écris un script js que j'ai incorporé dans la page. Pour faire ce script, je me suis servi de la docummentation leaflet https://leafletjs.com/. J'ai mis les points de coordonnées de nos trois universités. Même si l'affichage de la carte n'est parfait nous avons bien aimé la fonctionnalité et avond décidé de la garder.

--- 28/12/23 ---
PAGE TABLEAUX :

Des animations ont aussi été faites pour faire apparaître les tableaux par le biais de key frames. Le css associé est tableaux.css.


------------Baptiste-------------------------------------------

