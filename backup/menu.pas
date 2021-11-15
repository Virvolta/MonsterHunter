unit menu;

{$mode objfpc}{$H+}

interface

function menuPrincipal() : Integer;
procedure menuQuitter();
function menuHistoire() : Integer;
procedure menuPerso();
procedure menuLauncher();
procedure menuChambre();
function menuJeu() : Integer;
procedure forge();
procedure marchand();
procedure cantine();

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
  pos.x := 30;
  pos.y := 16;
  ecrireEnPosition(pos, ' /\  /\');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '//\\//\\');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '\ ^  ^ /');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '( 0  0 )');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '|  \/  |');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '( [--] )');
  pos.x := 29;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'  \____/ ');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, ' __|  |__ ' );
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'/__    __\ ');
 pos.x := 27;
 pos.y := pos.y+1;
 ecrireEnPosition(pos,'{-/ /    \ \-}');
  pos.x := pos.x+4;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,  '|----|');
  pos.x := pos.x;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,  '||\/||');
  pos.x := pos.x-1;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, '_||  ||_');
  pos.x := pos.x-1;
  pos.y := pos.y+1;
  ecrireEnPosition(pos,'/__\  /__\');

  dessinerCadreXY(10,7,70,15,simple,255,0);
  pos.x := 14;
  pos.y := 9;
  ecrireEnPosition(pos, 'Sexe : ');
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
  pos.y := 6;
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
  jeu := c;
end;

procedure menuChambre();
begin
  effacerEcran();
  dessinerCadreXY(2,2,50,25,simple,255,0);
  dessinerCadreXY(70,2,118,25,simple,255,0);
  dessinerCadreXY(2,26,118,28,simple,255,0);
  pos.x := 22;
  pos.y := 13;
  ecrireEnPosition(pos, '1)Lit');
  pos.x := 90;
  pos.y := 13;
  ecrireEnPosition(pos, '2)Armoire');
  pos.x := 56;
  pos.y := 27;
  ecrireEnPosition(pos, 'Choix : ');

end;

procedure forge();
begin

end;

procedure marchand();
begin

end;

procedure cantine();
begin

end;

end.

