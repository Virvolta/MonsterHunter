unit menu;

{$mode objfpc}{$H+}

interface

function menuPrincipal() : Integer;
procedure menuQuitter();
function menuHistoire() : Integer;
procedure menuPerso();
procedure menuLauncher();
function menuJeu() : Integer;
function menuInventaire():integer;


implementation
uses
  Classes, SysUtils, ihm, logique, personnage, controle;

var
   pos : coordonnees;


function menuPrincipal() : integer;
var
    b : integer;
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
{function menuPrincipal() : integer;
var
  ch : char;
begin;
  {repeat
    ch:=ReadKey;
    case ch of
     #0 : begin
            ch:=ReadKey; {Read ScanCode}
            case ch of
             #75 : WriteLn('Left');
             #77 : WriteLn('Right');
            end;
          end;
    #27 : WriteLn('ESC');
    end;
  until ch=#27 {Esc}}

  readln();
  menuPrincipal := 1;
end;}

procedure menuPerso();

var
    nom : string;
    selectsexe : char;
    taille : Integer;
    poids : Integer;
    pos : coordonnees;

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
  ecrireEnPosition(pos, 'Sexe(m ou f) : ');
  readln(selectsexe);
  setSexeChar(selectsexe);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Pseudo : ');
  readln(nom);
  setPseudo(nom);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Taille (cm): ');
  readln(taille);
  setTaille(taille);
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, 'Poids (Kg): ');
  readln(poids);
  setPoid(poids);
  menuLauncher();
end;



procedure menuLauncher();
var
   p: string;
   pos : coordonnees;
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
  ecrireEnPosition(pos, concat('Votre sexe : ', getSexeString()));
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, concat('Votre Pseudo : ', getPseudo()));
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, concat('Votre Taille : ', IntToStr(getTaille()), ' cm'));
  pos.x := 14;
  pos.y := pos.y+1;
  ecrireEnPosition(pos, concat('Votre Poid : ', IntToStr(getPoid()), ' kg'));
  pos.x := 14;
  pos.y := 19;
  ecrireEnPosition(pos, 'appuyer sur entree pour continuer : ');
  readln(p);
  pieces();
end;

function menuHistoire() : Integer;
var
   a : Integer;
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

function menuJeu() : Integer;
var
   c : integer;
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
  pos.y := 3;
  ecrireEnPosition(pos, '5)Chasser ');
  pos.x := 53;
  pos.y := 13;
  ecrireEnPosition(pos, 'Choix : ');

  readln(c);
  menuJeu := c;
end;

function menuInventaire():integer;
var
   j:integer;
begin
  effacerEcran();
  dessinerCadreXY(30,1,100,30,simple,255,0);
  pos.x := 38;
  pos.y := 5;
  ecrireEnPosition(pos, '1');
  dessinerCadreXY(40,3,50,7,simple,255,0);
  dessinerCadreXY(51,3,61,7,simple,255,0);
  dessinerCadreXY(62,3,72,7,simple,255,0);
  dessinerCadreXY(73,3,83,7,simple,255,0);
  dessinerCadreXY(84,3,94,7,simple,255,0);

  pos.x := 38;
  pos.y := 15;
  ecrireEnPosition(pos, '6');
  dessinerCadreXY(40,13,50,17,simple,255,0);
  dessinerCadreXY(51,13,61,17,simple,255,0);
  dessinerCadreXY(62,13,72,17,simple,255,0);
  dessinerCadreXY(73,13,83,17,simple,255,0);
  dessinerCadreXY(84,13,94,17,simple,255,0);

  pos.x := 38;
  pos.y := 20;
  ecrireEnPosition(pos, '11');
  dessinerCadreXY(40,18,50,22,simple,255,0);
  dessinerCadreXY(51,18,61,22,simple,255,0);
  dessinerCadreXY(62,18,72,22,simple,255,0);
  dessinerCadreXY(73,18,83,22,simple,255,0);
  dessinerCadreXY(84,18,94,22,simple,255,0);

  pos.x := 38;
  pos.y := 25;
  ecrireEnPosition(pos, '16');
  dessinerCadreXY(40,23,50,27,simple,255,0);
  dessinerCadreXY(51,23,61,27,simple,255,0);
  dessinerCadreXY(62,23,72,27,simple,255,0);
  dessinerCadreXY(73,23,83,27,simple,255,0);
  dessinerCadreXY(84,23,94,27,simple,255,0);

  pos.x := 31;
  pos.y := 29;
  ecrireEnPosition(pos, '21)Retourner au menu vente');
  pos.x := 31;
  pos.y := 2;
  ecrireEnPosition(pos, 'choix : ');
  readln(j);
  menuInventaire:=j;
end;




end.

