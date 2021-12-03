unit menu;

{$mode objfpc}{$H+}

interface

function menuPrincipal(): integer;
procedure menuQuitter();
procedure menuHistoire();
procedure menuPerso();
procedure menuLauncher();
function menuJeu(): integer;
function menuInventaire(): integer;
procedure nulSauvgarde();


implementation

uses
  Classes, SysUtils, ihm, logique, personnage, controle, outils;

var
  pos: coordonnees;

// cette fonction affiche le menu principal et demande a l'utilisateur de choisir ce qu'il veut faire
function menuPrincipal(): integer;
var
  ch: char;
  i: integer;
  select: integer;
begin
  effacerEcran();
  ascii('start', 0, 0);
  couleurs(0, 15);
  pos.x := 54;
  pos.y := 20;
  ecrireEnPosition(pos, 'Nouvelle partie');
  couleurs(15, 0);
  pos.x := 54;
  pos.y := 22;
  ecrireEnPosition(pos, 'Charger partie');
  pos.x := 54;
  pos.y := 24;
  ecrireEnPosition(pos, 'Histoire du jeu');
  pos.x := 54;
  pos.y := 26;
  ecrireEnPosition(pos, 'Quitter');
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select >= 5) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 4;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        deplacerCurseurXY(0, 0);
      end;
      4:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuPrincipal := select;
end;

// cette procedure lance la personalisation du perso
procedure menuPerso();

var
  nom: string;
  selectsexe: string;
  taille: string;
  poids: string;
  pos: coordonnees;
  b: boolean;
  select: integer;
  ch: char;

begin
  effacerEcran();
  ascii('personnage', 0, 0);
  pos.x := 13;
  pos.y := 9;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');

  deplacerCurseurXY(0, 0);
  pos.x := 13;
  pos.y := 3;
  ecrireEnPosition(pos, 'Entrer votre pseudo : ');
  readln(nom);
  setPseudo(nom);
  pos.x := 13;
  pos.y := 5;
  ecrireEnPosition(pos, 'Entrer votre taille(cm) : ');
  readln(taille);
  b := False;
  repeat
    try
      setTaille(StrToInt(taille));
      b := True;
    except
      on Exception: EConvertError do
      begin
        couleurs(4, 0);
        pos.x := 13;
        pos.y := 9;
        ecrireEnPosition(pos,
          'Veuillez mettre uniquement des chiffres               ');
        couleurs(15, 0);
        pos.x := 13;
        pos.y := 5;
        ecrireEnPosition(pos,
          'Entrer votre taille(cm) :                             ');
        ecrireEnPosition(pos, 'Entrer votre taille(cm) : ');
        readln(taille);
      end;

    end;
  until b;
  pos.x := 13;
  pos.y := 9;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider                       ');
  pos.x := 13;
  pos.y := 7;
  ecrireEnPosition(pos, 'Entrer votre poid(kg) : ');
  readln(poids);
  b := False;
  repeat
    try
      setPoid(StrToInt(poids));
      b := True;
    except
      on Exception: EConvertError do
      begin
        couleurs(4, 0);
        pos.x := 13;
        pos.y := 9;
        ecrireEnPosition(pos,
          'Veuillez mettre uniquement des chiffres               ');
        couleurs(15, 0);
        pos.x := 13;
        pos.y := 7;
        ecrireEnPosition(pos,
          'Entrer votre poid(kg) :                               ');
        ecrireEnPosition(pos, 'Entrer votre poid(kg) : ');
        readln(poids);
      end;
    end;
  until b;
  ascii('boy', 89, 3);
  pos.x := 13;
  pos.y := 9;
  ecrireEnPosition(pos, 'Pour change le personnage(les fleches directionnelle)');
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'M':
      begin
        select := select + 1;
        if (select >= 3) then
          select := 1;
      end;
      'K':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;
    case select of
      1:
      begin
        ascii('boy', 89, 3);
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        ascii('girl', 89, 3);
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  if (select = 1) then
    setSexe(m)
  else
    setSexe(f);
  menuLauncher();
end;

// cette procedure afiiche les caracteristiques du perso et lui demande si il veut entrer dans la ville
procedure menuLauncher();
var
  p: string;
  pos: coordonnees;
  ch: char;
  select: integer;
begin
  effacerEcran();
  ascii('personnage2', 0, 0);
  if (getSexe() = m) then
    ascii('boy', 1, 2)
  else
    ascii('girl', 1, 2);
  pos.x := 30;
  pos.y := 1;
  ecrireEnPosition(pos, concat('Votre sexe : ', getSexeString()));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Pseudo : ', getPseudo()));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Taille : ', IntToStr(getTaille()), ' cm'));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Poid : ', IntToStr(getPoid()), ' kg'));
  pos.x := 30;
  pos.y := 19;
  ecrireEnPosition(pos, 'Etes vous sure de vos choix');
  pos.x := 30;
  pos.y := 21;
  ecrireEnPosition(pos, 'Oui');
  couleurs(0, 15);
  pos.x := 35;
  pos.y := 21;
  ecrireEnPosition(pos, 'Non');
  couleurs(15, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'M':
      begin
        select := select + 1;
        if (select >= 3) then
          select := 1;
      end;
      'K':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 21;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 30;
        pos.y := 21;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 30;
        pos.y := 21;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 21;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  if (select = 1) then
    menuPerso()
  else
    pieces();
end;

// cette procedure affiche le prelude du jeu
procedure menuHistoire();
var
  a: integer;
  i: integer;
  c: integer;
  ch: char;
begin
  effacerEcran();
  ascii('prelude', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour revenir au menu principale');
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
  until ch = #13;
end;

// cette procedure permet de quitter
procedure menuQuitter();
begin
  effacerEcran();
  ascii('marchand_achat',0,0);
  pos.x := 52;
  pos.y := 12;
  ecrireEnPosition(pos, 'Bonne journee');
  deplacerCurseurXY(0, 0);
end;

// cette fonction nous permet de lancer la ville
function menuJeu(): integer;
var
  c: integer;
  ch: char;
  select : Integer;
  pos: coordonnees; 
  pos2: coordonnees;
  b : boolean;
begin
  effacerEcran();
  b := false;
  couleurs(15, 0);
  ascii('village', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  pos.x := 46;
  pos.y := 14;
  deplacerCurseurXY(pos.x, pos.y);
  couleurs(3, 0);
  write(char(219),char(219));
  couleurs(15, 0);
  // 1 = menu 2 = forge 3 = cantine 4 = shop 5 = interchassechambre 6 = chasse 7 = chambre 8 = quitter
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      #13:
      begin
        if ((select = 1) or (select = 5)) then
          begin
          couleurs(4, 0);
          pos2.x := 77;
          pos2.y := 28;
          ecrireEnPosition(pos2, 'Veuillez selectionner un emplacement valide');
          couleurs(15,0);
          end
        else
            b := true;
        deplacerCurseurXY(0, 0);
      end;
      'P':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 3;
             animationdeplacement(pos.x, pos.y, 0, 2);
             pos.y := pos.y + 4;
             end;
             4:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, 0, 2);
             pos.y := pos.y + 4;
             end;
             6:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, 0, 2);
             pos.y := pos.y + 4;
             end;
             5:
             begin
             select := 8;
             animationdeplacement(pos.x, pos.y, 0, 2);
             pos.y := pos.y + 4;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;
      'H':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 4;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             3:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             5:
             begin
             select := 6;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             8:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;
      'M':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, 16, 0);
             pos.x := pos.x + 32;
             end;
             2:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, 11, 0);
             pos.x := pos.x + 22;
             end;
             5:
             begin
             select := 7;
             animationdeplacement(pos.x, pos.y, 6, 0);
             pos.x := pos.x + 12;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;
      'K':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 2;
             animationdeplacement(pos.x, pos.y, -11, 0);
             pos.x := pos.x - 22;
             end;
             5:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, -16, 0);
             pos.x := pos.x + -32;
             end;
             7:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, -6, 0);
             pos.x := pos.x - 12;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;

    end;
  until ((ch = #13) and (b = true));
  menuJeu := select;
end;

// cette fonction permet de lancer l'inventaire
function menuInventaire(): integer;
var
  j: integer;
begin
  effacerEcran();
  dessinerCadreXY(30, 1, 100, 30, simple, 255, 0);
  pos.x := 38;
  pos.y := 5;
  ecrireEnPosition(pos, '1');
  dessinerCadreXY(40, 3, 50, 7, simple, 255, 0);
  dessinerCadreXY(51, 3, 61, 7, simple, 255, 0);
  dessinerCadreXY(62, 3, 72, 7, simple, 255, 0);
  dessinerCadreXY(73, 3, 83, 7, simple, 255, 0);
  dessinerCadreXY(84, 3, 94, 7, simple, 255, 0);

  pos.x := 38;
  pos.y := 15;
  ecrireEnPosition(pos, '6');
  dessinerCadreXY(40, 13, 50, 17, simple, 255, 0);
  dessinerCadreXY(51, 13, 61, 17, simple, 255, 0);
  dessinerCadreXY(62, 13, 72, 17, simple, 255, 0);
  dessinerCadreXY(73, 13, 83, 17, simple, 255, 0);
  dessinerCadreXY(84, 13, 94, 17, simple, 255, 0);

  pos.x := 38;
  pos.y := 20;
  ecrireEnPosition(pos, '11');
  dessinerCadreXY(40, 18, 50, 22, simple, 255, 0);
  dessinerCadreXY(51, 18, 61, 22, simple, 255, 0);
  dessinerCadreXY(62, 18, 72, 22, simple, 255, 0);
  dessinerCadreXY(73, 18, 83, 22, simple, 255, 0);
  dessinerCadreXY(84, 18, 94, 22, simple, 255, 0);

  pos.x := 38;
  pos.y := 25;
  ecrireEnPosition(pos, '16');
  dessinerCadreXY(40, 23, 50, 27, simple, 255, 0);
  dessinerCadreXY(51, 23, 61, 27, simple, 255, 0);
  dessinerCadreXY(62, 23, 72, 27, simple, 255, 0);
  dessinerCadreXY(73, 23, 83, 27, simple, 255, 0);
  dessinerCadreXY(84, 23, 94, 27, simple, 255, 0);

  pos.x := 31;
  pos.y := 29;
  ecrireEnPosition(pos, '21)Retourner au menu vente');
  pos.x := 31;
  pos.y := 2;
  ecrireEnPosition(pos, 'choix : ');
  readln(j);
  menuInventaire := j;
end;

procedure nulSauvgarde();

begin
  effacerEcran;
  couleurs(15,0);
  ascii('marchand_achat',0,0);
  pos.x := 40;
  pos.y := 12;
  ecrireEnPosition(pos,'Vous n''avez pas de partie sauvgarder');
  deplacerCurseurXY(0,0);
  readln();
end;

end.
