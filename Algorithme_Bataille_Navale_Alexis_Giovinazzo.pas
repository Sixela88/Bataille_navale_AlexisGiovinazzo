{Sujet TP : Bataille navale (notion abordée => tableaux / structures / fonctions et procédures)
Réaliser l'algo et le programme pascal de la bataille navale. Vous ne devez pas utiliser de tableau à 2 dimensions pour 
représenter la grille du jeu. 
Utiliser un type enregistrement "cellule" pour décrire les cellules occupées par les bateaux, de même un bateau sera décrit
par un ensemble de cellule et la flotte de bateau à couler sera représenté par un ensemble de bateaux.
Travail à faire : 
1) Ecrire la structure cellule composée de 2 champs lignes et colonnes des entiers
2) Ecrire la structure bateau composée d'un ensemble de n cellules
3) Ecrire le type enregistrement flotte composé d'un ensemble de bateau
4) Ecrire une fonction de création d'une cellule, elle prend en paramètre la ligne et la colonne associées à la cellule.
5) Ecrire une fonction de comparaison de 2 cellules. Cette fonction renverra vrai ou faux selon le cas.
6) Ecrire une fonction de création de bateau, elle renverra un type enregistrement "bateau" correctement rempli
7) Ecrire une fonction qui vérifie qu'une cellule appartient à un bateau, cette fonction renverra vrai ou faux selon le cas.
ATTENTION cette fonction de vérification devra utiliser la fonction de comparaison de cellule.
8) Ecrire une fonction qui vérifie qu'une cellule appartient à une flotte de bateau.ATTENTION cette fonction devra utiliser 
la fonction de vérification de bateau.
9) La bataille navale complète.
}

//ALGO : Bataille navale
// BUT : Créer un jeu de bataille navale en utilisant des types ENREGISTREMENT
// ENTREES : Positions x et y
// SORTIES : Le joueur gagnant 

{CONST
	max:ENTIER<-10
	nbbat:ENTIER<-3
	nbjoueur:ENTIER<-2


//1) Ecrire la structure cellule composée de 2 champs lignes et colonnes des entiers
Type
	cellule = ENREGISTREMENT
		x,y:ENTIER 
FIN

//Tableau de cellule pour chaque bateau
Type
	 CellBateau=tableau[1..nbbat] de cellule

//2) Ecrire la structure bateau composée d'un ensemble de n cellules
Type
	bateau = ENREGSITREMENT
		tabbat:CellBateau
FIN

// Tableau pour la ou les flotte(s)
Type 
	TabFlotte=tableau[1..2] de bateau

//3) Ecrire le type enregistrement flotte composé d'un ensemble de bateau
Type
	flotte = ENREGISTREMENT
		tabflot:TabFlotte
FIN

//4) Ecrire une fonction de création d'une cellule, elle prend en paramètres la ligne et la colonne associées à la cellule.
fonction CreationCellule(x,y:ENTIER):cellule
//ENTREES : positions x et y
//SORTIES : 

VAR
	cell:cellule

DEBUT
	cell.x<-x
	cell.y<-y
	CreationCellule<-cell
FIN FONCTION

//6) Ecrire une fonction de création de bateau, elle renverra un type enregistrement "bateau" correctement rempli

procedure CreationBateau(VAR tabbateau:TabFlotte;VAR x,y:ENTIER;flot:ENTIER)
//ENTREES : Tableau de la flotte et positions x et y
//SORTIES : Mauvaise position ou rien

VAR
	i:ENTIER

DEBUT
	POUR i DE 1 A nbbat FAIRE  
		REPETER
			ECRIRE("Veuillez entrer la position de départ X et Y du bateau "&i)
			LIRE(x)
			LIRE(y)
			tabbateau[flot].tabbat[i]<-CreationCellule(x,y)
			SI (x>10) OU (x<0) OU (y>10) OU (y<0) ALORS
				ECRIRE("Mauvaise saisie de la position x/y. Veuillez resaisir la position.")
			FINSI
		JUSQU'A (x<=10) ET (x>0) ET (y<=10) ET (y>0)
	FINPOUR
FIN PROCEDURE

//5) Ecrire une fonction de comparaison de 2 cellules. Cette fonction renverra vrai ou faux selon le cas.
//7) Ecrire une fonction qui vérifie qu'une cellule appartient à un bateau, cette fonction renverra 
vrai ou faux selon le cas.
ATTENTION cette fonction de vérification devra utiliser la fonction de comparaison de cellule.
//8) Ecrire une fonction qui vérifie qu'une cellule appartient à une flotte de bateau.ATTENTION cette fonction devra utiliser 
la fonction de vérification de bateau.

procedure VerifBateau(VAR tabbateau:TabFlotte; b:BOOLEEN; x,y:ENTIER; stock:BOOLEEN; flot:ENTIER)
//ENTREES : Tableau de la flotte et positions x et y
//SORTIES : Touché ou raté

VAR
	i:ENTIER
	cpt:ENTIER

DEBUT
	REPETER
		stock<-FALSE
		ECRIRE("Veuillez entrer une position de tir")
		LIRE(x,y)

		POUR cpt DE 1 A nbbat FAIRE 
			i<-cpt			
			SI (x=tabbateau[flot].tabbat[i].x) ET (y=tabbateau[flot].tabbat[i].y) ALORS
				b<-TRUE
				stock<-b
				tabbateau[flot].tabbat[i].x<-0
				tabbateau[flot].tabbat[i].y<-0
			SINON
				b<-FALSE
			FINSI

			SI (stock=TRUE) ALORS
				b<-True
				ECRIRE("Touché en position x=",x," et y=",y," ! Vous avez le droit de tirer à nouveau !")
			SINON
				ECRIRE("Raté")
				b<-FALSE
			FINSI
		FINPOUR
	JUSQU'A (b=FALSE)
FIN PROCEDURE


//Programme principal :

VAR
	i,j,x,y:ENTIER
	tabbateau:TabFlotte
	b:BOOLEEN
	stock:BOOLEEN
	flot:ENTIER
	fin:ENTIER
	joueur:ENTIER
	joueurgagnant:ENTIER

DEBUT

	ECRIRE("Bataille navale sur une carte de 10x10. Donc X et Y min=1 et max=10.")
	ECRIRE("Veuillez créer vos bateaux")
	POUR joueur DE 1 A nbjoueur FAIRE
		ECRIRE("Le joueur "&joueur&" cree sa flotte :")
		CreationBateau(tabbateau,x,y,joueur)
	FINPOUR

	ECRIRE("La partie peut commencer :")
	REPETER
		joueur<-1
		POUR joueur DE 1 A nbjoueur FAIRE

			SI joueur=1 ALORS
				flot<-2
			SINON
				flot<-1
			FINSI

			ECRIRE("Le joueur "&joueur&" joue !")
			VerifBateau(tabbateau,b,x,y,stock,flot)
				
			//Verification bateaux restants
			POUR flot DE 1 A nbjoueur FAIRE 
				POUR i DE 1 A nbbat FAIRE
					SI (tabbateau[1].tabbat[i].x>0) OU (tabbateau[1].tabbat[i].y>0) ALORS
						SI (tabbateau[2].tabbat[i].x>0) OU (tabbateau[2].tabbat[i].y>0) ALORS
							fin<-0
						SINON
							fin<-1
							joueurgagnant<-1
						FINSI

					SINON
						fin<-1
						joueurgagnant<-2
					FINSI
				FINPOUR
			FINPOUR

		FIN POUR

	JUSQU'A fin=1
	ECRIRE("Bravo ! La partie est terminee.Le joueur "&joueurgagnant&" gagne !")

FIN