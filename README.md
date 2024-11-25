# Voidwalker
Miguel Croteau Brochu

## Concept du jeu
Voidwalker est un jeu de type platformer qui est composé de deux niveaux qui peuvent être refait à l'infini pour augmenter son score, mais la difficulté augmentera à chaque niveau.
On peut voir ces niveaux infini comme un système de gamble quand tu termines le niveau 2 tu as le choix de t'arrêter et enregistrer ton score ou de continuer pour l'augmenter. 
Il y a des ennemies (FlyingGolem) et des traps (Scies) qui sont là pour empêcher le joueur de réussir le niveau, mais en contre partie il y a des collectables (Toast à la framboise) qui permettent de récupérer des points de vie. 
Pour terminer le premier niveau on doit tuer les x ennemies qui sont présents dans le niveau et pour le niveau 2 il faut tuer le boss qui est plus puissant que les ennemies de base. 

## Caméra basée sur la "room" que le joueur se trouve
La caméra ne suivra pas le joueur, mais elle va se positionner au milieu de la "room" que le joueur se trouvent.
Premièrement, le joueur possède une area2D qui fait office de détecteur de room qui à la ma même shape que sa collision shape.
Il est connecter au singal area_entered, quand le signal est appelé, je verifie si l'area dans laquel il vient d'entrer est une room, et si oui j'enregistre dans une variable la collision shape de la room. 
J'ai un RoomTransition qui est global qui me permet de transitionner de room. J'appel sa fonction change_room en paramètres je lui passe la position de la collision shape et le size de la collision shape * 2 (Pour matcher la size de l'écran quand on fera des calculs avec plus tard). 
Dans le script de la caméra, super important on récupère la size de l'écran (@onready var view_size: Vector2 = get_viewport_rect).
Dans le physics_process je calcul la size de l'écran en multipliant le zoom (view_size * zoom).
Par la suite, dans une fonction en lui passant la position de la room et la room size.
Dans cette fonction, J'ai calculé s'il y avait de la margin pour le x et le y (Si la salle était plus grande que l'écran peut afficher).
( var x_margin: float = (room_size.x - zoom_view_size.x) / 2
var y_margin: float = (room_size.y - zoom_view_size.y) / 2 )
C'est ce calcul que je voulais revenir dessus, j'ai multiplié par deux dans un calcul avant puisque évidement que la room sera pratiquement toujours plus petite que la taille de l'écran, mais on souhaite afficher juste la room, alors on va multiplier par 2 pour savoir s'il elle rentre dans l'écran et sinon la margin nécessaire pour pouvoir déplacer la caméra quand le joeur se déplace.
Si elle est trop grande on ne pourra pas la voir au complet quand on se déplace alors il y aura un moment qu'on ne voirait pas le player.
Continuons, je vérifie si la margin est plus grande que 0 et si oui j'ajoute et soustrait à la position x et/ou y et j'utilise la fonction clampf() pour ne jamais dépasser ma limite sinon si la margin est plus petite ou égale à 0 je mets juste la valeur du centre de la room et je retourne le Vector2
Dans le physic process je récupère le Vector2 et j'appel la fonction lerp (position = lerp(position, target_position, smoothing)) afin que la position de la caméra se déplace à un rythme constant et smooth.

![Camera Transition](/voidwalker/Images/GodotEngine2024.11.25-12.30.16.03-ezgif.com-video-to-gif-converter.gif)

Source : https://www.youtube.com/watch?v=DBgIES-CIUI&t=0s&ab_channel=Verrazano