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

Program bataille_navale;

uses crt;

CONST
	max=10;
	nbbat=3;
	nbjoueur=2;


//1) Ecrire la structure cellule composée de 2 champs lignes et colonnes des entiers
Type
	cellule = record
		x,y:integer; 
end;

//Tableau de cellule pour chaque bateau
Type
	 CellBateau=Array[1..nbbat] of cellule;

//2) Ecrire la structure bateau composée d'un ensemble de n cellules
Type
	bateau = record
		tabbat:CellBateau;
end;

// Tableau pour la ou les flotte(s)
Type 
	TabFlotte=Array[1..2] of bateau;

//3) Ecrire le type enregistrement flotte composé d'un ensemble de bateau
Type
	flotte = record
		tabflot:TabFlotte;
end;	


//4) Ecrire une fonction de création d'une cellule, elle prend en paramètres la ligne et la colonne associées à la cellule.
function CreationCellule(x,y:integer):cellule;

VAR
	cell:cellule;

BEGIN
	cell.x:=x;
	cell.y:=y;
	CreationCellule:=cell; //On crée une cellule à cellule de position x et y.
END;

//6) Ecrire une fonction de création de bateau, elle renverra un type enregistrement "bateau" correctement rempli

procedure CreationBateau(Var tabbateau:TabFlotte;x,y:integer;flot:integer);

VAR
	i:integer;

BEGIN
	FOR i:=1 TO nbbat DO // Du bateau numéro 1 au 5 faire 
		BEGIN
			REPEAT
				BEGIN
					writeln(UTF8ToAnsi('Veuillez entrer la position de départ X et Y du bateau '),i);
					readln(x);
					readln(y);
					tabbateau[flot].tabbat[i]:=CreationCellule(x,y); // Dans la tableau flot, à la position du tableau bateau, on crée une cellule x,y
					IF (x>10) OR (x<0) OR (y>10) OR (y<0) THEN // Si x ou y est supérieur à 10 alors mauvaise saisie.
						writeln('Mauvaise saisie de la position x/y. Veuillez resaisir la position.');
				END;
			UNTIL (x<=10) AND (x>0) AND (y<=10) AND (y>0);
		END;
END;

//5) Ecrire une fonction de comparaison de 2 cellules. Cette fonction renverra vrai ou faux selon le cas.
{7) Ecrire une fonction qui vérifie qu'une cellule appartient à un bateau, cette fonction renverra 
vrai ou faux selon le cas.
ATTENTION cette fonction de vérification devra utiliser la fonction de comparaison de cellule.
8) Ecrire une fonction qui vérifie qu'une cellule appartient à une flotte de bateau.ATTENTION cette fonction devra utiliser 
la fonction de vérification de bateau.}

procedure VerifBateau(Var tabbateau:TabFlotte;b:boolean;x,y:integer;stock:boolean;flot:integer);

VAR
	i:integer;
	cpt:integer;

BEGIN
	REPEAT
		BEGIN
			stock:=FALSE;
			writeln('Veuillez entrer une position de tir');
			readln(x,y);

			FOR cpt:=1 TO nbbat DO // Pour 1 à nombre de bateau, on vérifie que la position saisie ne soit pas égale à une position de bateau
				BEGIN
					i:=cpt;			
					IF (x=tabbateau[flot].tabbat[i].x) AND (y=tabbateau[flot].tabbat[i].y) THEN //Vérifie que le joueur touche une cellule ocupée par un bateau
						BEGIN
							b:=TRUE;
							stock:=b;
							tabbateau[flot].tabbat[i].x:=0; //x et y prennent la valeur 0 donc la cellule n'existe pu
							tabbateau[flot].tabbat[i].y:=0;
						END
					ELSE
						BEGIN
							b:=FALSE; 
						END;
				END;

			IF (stock=TRUE) THEN 
				BEGIN//Si la position saisie est identique à une position de bateau alors apparait :
					b:=True;
					writeln(UTF8ToAnsi('Touché en position x='),x,' et y=',y,UTF8ToAnsi(' ! Vous avez le droit de tirer à nouveau !')) // Touché
				END
			ELSE
				BEGIN
					writeln(UTF8ToAnsi('Raté')); //Sinon Raté
					b:=FALSE;
				END;
		END;
	UNTIL (b=FALSE); // Quand le joueur rate, il finit son "tour"
END;


//Programme principal :

VAR
	i,j,x,y:integer;
	tabbateau:TabFlotte;
	b:boolean;
	stock:boolean;
	flot:integer;
	fin:integer;
	joueur:integer;
	joueurgagnant:integer;

BEGIN
	clrscr;
	writeln('Bataille navale sur une carte de 10x10. Donc X et Y min=1 et max=10.');
	writeln(UTF8ToAnsi('Veuillez créer vos bateaux'));
	FOR joueur:=1 TO nbjoueur DO
		BEGIN
			writeln('Le joueur ',joueur,' cree sa flotte :');
			CreationBateau(tabbateau,x,y,joueur); //Appel la procédure
		END;

	writeln('La partie peut commencer :');
	REPEAT
		BEGIN
			joueur:=1;
			FOR joueur:=1 TO nbjoueur DO
				BEGIN
					IF joueur=1 THEN
						BEGIN
							flot:=2; //Si c'est le joueur 1 qui joue, la flotte visée est celle du joueur 2
						END
					ELSE
						BEGIN
							flot:=1; //Si c'est le joueur 2 qui joue, la flotte visée est celle du joueur 1
						END;
					writeln('Le joueur ',joueur,' joue !');
					VerifBateau(tabbateau,b,x,y,stock,flot); //Appel la procédure 

					//Verification bateaux restants
					FOR i:=1 TO nbjoueur DO // Du joueur 1 à 2 faire
						BEGIN
							FOR j:=1 TO nbbat DO // Du bateau numéro 1 au 5 faire 
								BEGIN
									IF (tabbateau[1].tabbat[j].x>0) OR (tabbateau[1].tabbat[j].y>0) THEN //Vérifie que le joueur a encore des bateaux(des positions)
										BEGIN
											IF (tabbateau[2].tabbat[j].x>0) OR (tabbateau[2].tabbat[j].y>0) THEN
												BEGIN
													fin:=0; // La partie n'est pas terminée. Il reste des bateaux.
												END
											ELSE
												BEGIN
													fin:=1; //La parte est terminée
													joueurgagnant:=1; //Le joueur 2 gagne
												END;
										END
									ELSE
										BEGIN
											fin:=1;
											joueurgagnant:=2; // Le joueur 1 gagne
										END;
								END;
						END;
				
				END;

			END;
					
	UNTIL fin=1; //Jusqu'à ce qu'un des joueurs n'est plus de bateaux
	writeln('Bravo ! La partie est terminee.Le joueur ',joueurgagnant,' gagne !'); //Fait apparaitre le gagnant et met fin à la partie
	readln;
END.