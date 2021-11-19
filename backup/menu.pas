unit menu;

{$mode objfpc}{$H+}

interface

function menuPrincipal() : Integer;
procedure menuQuitter();
function menuHistoire() : Integer;
procedure menuPerso();
procedure menuLauncher();
function menuChambre():Integer;
function menuJeu() : Integer;
procedure forge();
function menuMarchand(): Integer;
function menuCantine():Integer;
procedure menuLit();
procedure menuArmoire();
function menuVente():Integer;
procedure menuAchat;

implementation
uses
  Classes, SysUtils, ihm, logique;

var
   pos : coordonnees;
   b : integer;

function menuPrincipal() : integer;
begin
  effacerEcran();
  dessinerCadreXY(28,13,90,21,simple,255,0);
  couleurTexte(4);
  pos.x := 25;
  pos.y := 0;
  ecrireEnPosition(pos, ' __  __                 _              _    _             _ ');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '|  \/  |               | |            | |  | |           | |');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| \  / | ___  _ __  ___| |_ ___ _ __  | |__| |_   _ _ __ | |_ ___ _ __');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| |\/| |/ _ \| ''_ \/ __| __/ _ \ ''__| |  __  | | | | ''_ \| __/ _ \ ''__|');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| |  | | (_) | | | \__ \ ||  __/ |    | |  | | |_| | | | | ||  __/ |');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '|_|  |_|\___/|_| |_|___/\__\___|_|    |_|  |_|\__,_|_| |_|\__\___|_|');


  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,  ' _   _                                    _     _');
  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| \ | |                                  | |   | |');
  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '|  \| | _____      __ __      _____  _ __| | __| |');
  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| . ` |/ _ \ \ /\ / / \ \ /\ / / _ \| ''__| |/ _` |');
  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '| |\  |  __/\ V  V /   \ V  V / (_) | |  | | (_| |');
  pos.x := 33;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '|_| \_|\___| \_/\_/     \_/\_/ \___/|_|  |_|\__,_|');

  couleurTexte(15);
  pos.x := 50;
  pos.y := 15;
  ecrireEnPosition(pos, '1) Nouvelle partie');
  pos.x := 50;
  pos.y := 16;
  ecrireEnPosition(pos, '2) Histoire du jeu');
  pos.x := 50;
  pos.y := 17;
  ecrireEnPosition(pos, '3) Quitter');
  pos.x := 50;
  pos.y := 20;
  ecrireEnPosition(pos, 'Choix : ');
  readln(b);
  menuPrincipal := b;

end;
 var
    nom : string;
    prenom : string;
    sex : string;
    taille : real;
    poids : real;

procedure menuPerso();
begin
  effacerEcran();
  couleurTexte(4);
  pos.x := 5;
  pos.y := 1;
  ecrireEnPosition(pos, '  _____       __       _   _                   _');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,' / ____|     /_/      | | (_)                 | |');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'| |     _ __ ___  __ _| |_ _  ___  _ __     __| |_   _   _ __   ___ _ __ ___  ___  _ __  _ __   __ _  __ _  ___');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'| |    | ''__/ _ \/ _` | __| |/ _ \| ''_ \   / _` | | | | | ''_ \ / _ \ ''__/ __|/ _ \| ''_ \| ''_ \ / _` |/ _` |/ _ \');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'| |____| | |  __/ (_| | |_| | (_) | | | | | (_| | |_| | | |_) |  __/ |  \__ \ (_) | | | | | | | (_| | (_| |  __/');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,' \_____|_|  \___|\__,_|\__|_|\___/|_| |_|  \__,_|\__,_| | .__/ \___|_|  |___/\___/|_| |_|_| |_|\__,_|\__, |\___|');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'                                                        | |                                           __/ | ');
  pos.x := 5;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'                                                        |_|                                          |___/  ');


  couleurTexte(15);
  dessinerCadreXY(10,10,70,18,simple,255,0);
  pos.x := 14;
  pos.y := 11;
  ecrireEnPosition(pos, 'Sexe(M ou F) : ');
  readln(sex);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Nom : ');
  readln(nom);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Prenom : ');
  readln(prenom);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Taille (cm): ');
  readln(taille);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Poids (Kg): ');
  readln(poids);
  menuLauncher();
end;

var
   p: string;

procedure menuLauncher();
begin
  pos.x := 14;
  pos.y := 19;
  ecrireEnPosition(pos, 'appuyer sur entree pour continuer : ');
  readln(p);
  pieces();
end;

var
   a : Integer;
function menuHistoire() : Integer;
begin
effacerEcran();
dessinerCadreXY(10,7,110,20,simple,255,0);
couleurTexte(4);
pos.x := 40;
pos.y := 1;
ecrireEnPosition(pos,' _____       __ _           _ ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'|  __ \     /_/| |         | |');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'| |__) | __ ___| |_   _  __| | ___ ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'|  ___/ ''__/ _ \ | | | |/ _` |/ _ \');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'| |   | | |  __/ | |_| | (_| |  __/');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'|_|   |_|  \___|_|\__,_|\__,_|\___|');

couleurTexte(15);
pos.x := 14;
pos.y := 9;
ecrireEnPosition(pos, 'La commission des chasseurs est une institution chargee d''etudier et de chasser les ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'grands monstres qui peuplent le monde. Lors de la cinquieme expedition envoyee dans le ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'nouveau monde, la commission des chasseurs a decouvert l''existence d''une ile mysterieuse : ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'Aeternum, protegee par un etrange brouillard magique empechant les navires de s''y rendre ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'mais qui semble jouer un role important dans le cycle de migration des grands monstres. ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'Apres de nombreuses recherches, la commission a mis la main sur un artefact magique ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'ressemblant a une boussole, cense permettre d''acceder a l''ile. Vous faites partie de ');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'la sixieme grande expedition de chasseurs dont l''objectif est de decouvrir les secret');
pos.x := pos.x;
pos.y := pos.y+1;
ecrireEnPosition(pos,'d''Aeternum.');
pos.x := pos.x;
pos.y := pos.y+4;
ecrireEnPosition(pos,'1) Revenir au menu principale : ');
readln(a);
menuHistoire := a;

end;


procedure menuQuitter();
begin
effacerEcran();
dessinerCadreXY(28,13,90,15,simple,255,0);
pos.x := 52;
pos.y := 14;
ecrireEnPosition(pos, 'Bonne journee');
end;

var
   c : integer;

function menuJeu() : Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,2,27,4,simple,255,0);
  dessinerCadreXY(2,22,27,24,simple,255,0);
  dessinerCadreXY(92,2,118,4,simple,255,0);
  dessinerCadreXY(92,22,118,24,simple,255,0);
  dessinerCadreXY(52,12,65,14,simple,255,0);
  pos.x := 3;
  pos.y := 3;
  ecrireEnPosition(pos, '1)Aller dans la chambre');
  pos.x := 3;
  pos.y := 23;
  ecrireEnPosition(pos, '2)Aller a la forge');
  pos.x := 93;
  pos.y := 3;
  ecrireEnPosition(pos, '3)Aller chez le marchand');
  pos.x := 93;
  pos.y := 23;
  ecrireEnPosition(pos, '4)Aller a la cantine');
  pos.x := 53;
  pos.y := 13;
  ecrireEnPosition(pos, 'Choix : ');
  readln(c);
  menuJeu := c;
end;
var
   d : Integer;
function menuChambre():Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(70,3,118,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 22;
  pos.y := 14;
  ecrireEnPosition(pos, '1)Lit');
  pos.x := 90;
  pos.y := 14;
  ecrireEnPosition(pos, '2)Armoire');
  pos.x := 50;
  pos.y := 1;
  ecrireEnPosition(pos, '3)Retour a la ville');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(d);
  menuChambre := d;

end;
var
   e:string;
procedure menuLit();
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 58;
  pos.y := 13;
  ecrireEnPosition(pos, 'Bonne nuit');
  readln(e);
  if (e = '')then chambre()
  else menuLit();
end;

procedure menuArmoire();
begin
  effacerEtColorierEcran(6);
  dessinerCadreXY(2,2,50,25,simple,0,6);
  dessinerCadreXY(70,2,118,25,simple,0,6);
  dessinerCadreXY(2,27,118,29,simple,0,6);
  pos.x := 50;
  pos.y := 28;
  ecrireEnPosition(pos, '1)Retour a la chambre : ');
  readln(e);
  if (e = '1')then chambre()
  else menuArmoire();
end;

procedure forge();
begin

end;

var
   g: integer;

function menuMarchand(): Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(70,3,118,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 22;
  pos.y := 14;
  ecrireEnPosition(pos, '1)Acheter');
  pos.x := 90;
  pos.y := 14;
  ecrireEnPosition(pos, '2)Vendre');
  pos.x := 50;
  pos.y := 1;
  ecrireEnPosition(pos, '3)Retour a la ville');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(g);
  menuMarchand := g;
end;

var
   h: integer;

function menuVente():Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(70,3,118,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 50;
  pos.y := 1;
  ecrireEnPosition(pos, '3)Retour au menu marchand');
  pos.x := 4;
  pos.y := 4;
  ecrireEnPosition(pos, 'Deposer un objet (sauf arme et armure)');
  dessinerCadreXY(16,12,35,18,simple,255,0);
  pos.x := 17;
  pos.y := 19;
  ecrireEnPosition(pos, 'Appyuer sur 1 pour ');
  pos.X := 14;
  pos.y :=20;
  ecrireEnPosition(pos, 'entrer dans l''inventaire ');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(h);
  menuVente :=h;

end;
procedure menuAchat;
begin

end;

var
   f:Integer;

function menuCantine():Integer;
begin
  effacerEcran();
  dessinerCadreXY(40,5,80,25,simple,255,0);
  pos.x := 45;
  pos.y := 7;
  ecrireEnPosition(pos, 'Que voulez-vous manger : ');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '1)BOOST defense :''nom plat'' (prix)');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '2)BOOST degats :''nom plat'' (prix)');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '3)BOOST vie :''nom plat'' (prix)');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '4)BOOST vitesse :''nom plat'' (prix)');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '5)Retour a la ville : ');
  pos.x := 50;
  pos.y := 24;
  ecrireEnPosition(pos, 'Choix : ');
  readln(f);
  menuCantine:=f;
end;


end.

