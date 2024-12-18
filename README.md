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

## Ennemies intelligent
Le concept de mon ennemie intelligent est que s'il n'y a pas de joueur dans sa range il va se déplacer aléatoirement, mais quand un joueur est dans sa range il prendra le chemin le plus court à l'aide des nodes de pathfinding de godot et s'il est dans la range d'attaque il va l'attaquer et pour finir le joueur doit se trouver dans l'area d'attaque de l'ennemie quand il attaque pour subir les dégats. 
Premièrement, l'ennemie possède un node NavigationAgent2D, on lui ajoute 2 timer, 1 pour recalculer le path et l'autre pour la direction aléatoire dans laquelle il ira quand il n'y a pas de joueur. 
On va binder le signal sur les deux timer. 
Pour celui du déplacement aléatoire on va regarder si l'ennemie chase un player, s'il ne chase pas de player on change le wait_time du timer pour un nombre aléatoire et on change sa direction pour un Vector2 aléatoire ([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP]). 
Mon ennemie a deux area2D une aggro range et un de aggro range (Aggro range est plus petit que le de aggro range alors la distance pour aggro est plus petite, mais pour perdre l'aggro la distance sera plus grandre). 
Quand un joueur rentre dans la zone d'aggro l'ennemie il va commencer à poursuivre le player à l'aide de la node NavigationAgent2D qui va lui permettre de trouver le chemin le plus court. 
Dans mon script de mon ennemiem je calcul la distance entre mon player et mon ennemie et si la distance est plus petite ou égale que mon attack_distance l'ennemie attaque. 
Mon ennemie a un area2D pour son attaque qui a le setting monitoring a false de base. 
Pour l'activer, je gère le paramètre dans l'animation player. 
Je mets le monitoring à true quand l'animation de l'ennemie attaque et quand elle est terminée je le remets à false.

![Ennemies intelligent](/voidwalker/Images/Attack.gif)

Source : https://www.youtube.com/watch?v=1-f4WEy0GBg&t=1079s&ab_channel=Queble