unit uniteCantine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage,outils,controle;

procedure defense();
procedure degats();
procedure vie();
procedure vitesse();
function menuCantine():Integer;

implementation

var
   pos : coordonnees;


// cette fonction montre ce que le joueur peut acheter et lui demande de choisir ce qu'il veut
function menuCantine():Integer;
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('cantine', 0, 0);
  pos.x := 35;
  pos.y := 7;
  deplacerCurseurXY(pos.x, pos.y);
  write('Que voulez-vous manger ', getpseudo);
  couleurs(0, 15);
  pos.x := pos.x;
  pos.y := 10;
  ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
  couleurs(15, 0);
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
  pos.x := pos.x;
  pos.y := 24;
  ecrireEnPosition(pos, 'Retour a la ville : ');
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
        if (select >= 6) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 5;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 10;
        ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 12;
        ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
        pos.x := 35;
        pos.y := 14;
        ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
        pos.x := 35;
        pos.y := 16;
        ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
        pos.x := 35;
        pos.y := 24;
        ecrireEnPosition(pos, 'Retour a la ville : ');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 12;
        ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 14;
        ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
        pos.x := 35;
        pos.y := 16;
        ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
        pos.x := 35;
        pos.y := 24;
        ecrireEnPosition(pos, 'Retour a la ville : ');
        pos.x := 35;
        pos.y := 10;
        ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 14;
        ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 16;
        ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
        pos.x := 35;
        pos.y := 24;
        ecrireEnPosition(pos, 'Retour a la ville : ');
        pos.x := 35;
        pos.y := 10;
        ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
        pos.x := 35;
        pos.y := 12;
        ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
        deplacerCurseurXY(0, 0);
      end;
      4:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 16;
        ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 24;
        ecrireEnPosition(pos, 'Retour a la ville : ');
        pos.x := 35;
        pos.y := 10;
        ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
        pos.x := 35;
        pos.y := 12;
        ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
        pos.x := 35;
        pos.y := 14;
        ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
        deplacerCurseurXY(0, 0);
      end;
      5:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 24;
        ecrireEnPosition(pos, 'Retour a la ville : ');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 10;
        ecrireEnPosition(pos, 'BOOST defense : Risoto au champi vitalis : 15');
        pos.x := 35;
        pos.y := 12;
        ecrireEnPosition(pos, 'BOOST degats : soupe de corne de dragon : 20');
        pos.x := 35;
        pos.y := 14;
        ecrireEnPosition(pos, 'BOOST vie : viande grillee : 12');
        pos.x := 35;
        pos.y := 16;
        ecrireEnPosition(pos, 'BOOST vitesse : saute de pimants : 10');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuCantine := select;

end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure defense();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);

  if hasMoney(15) then
  begin
    pos.x := 45;
    pos.y := 13;
    ecrireEnPosition(pos, 'Vous avez un boost de 5 en defense ');
    delMoney(15);
  end
  else
  begin
    pos.x := 54;
    pos.y := 13;
    deplacerCurseurXY(pos.x, pos.y);
    write('vous n''avez que ', getMoney);
  end;

  readln(k);
  if (k = '')then cantine()
  else defense();
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure degats();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);

  if hasMoney(20) then
  begin
    pos.x := 45;
    pos.y := 13;
    ecrireEnPosition(pos, 'Vous avez un boost de 3 en degats ');
    delMoney(20);
  end
  else
  begin
    pos.x := 54;
    pos.y := 13;
    deplacerCurseurXY(pos.x, pos.y);
    write('vous n''avez que ', getMoney);
  end;

  readln(k);
  if (k = '')then cantine()
  else degats();
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure vie();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);

  if hasMoney(12) then
  begin
    pos.x := 48;
    pos.y := 13;
    ecrireEnPosition(pos, 'Vous avez de la vie en plus ');
    delMoney(12);
  end
  else
  begin
    pos.x := 54;
    pos.y := 13;
    deplacerCurseurXY(pos.x, pos.y);
    write('vous n''avez que ', getMoney);
  end;

  readln(k);
  if (k = '')then cantine()
  else vie();
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure vitesse();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);

  if hasMoney(12) then
  begin
    pos.x := 40;
    pos.y := 13;
    ecrireEnPosition(pos, 'Vous pouvez vous deplasser 1,5 fois plus vite ');
    pos.x := 50;
    pos.y := 14;
    ecrireEnPosition(pos, 'pendant 2 minutes ');
    delMoney(12);
  end
  else
  begin
    pos.x := 54;
    pos.y := 13;
    deplacerCurseurXY(pos.x, pos.y);
    write('vous n''avez que ', getMoney);
  end;

  readln(k);
  if (k = '')then cantine()
  else vitesse();
end;
end.

