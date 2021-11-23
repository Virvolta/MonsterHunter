unit uniteCantine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique;

procedure defense();
procedure degats();
procedure vie();
procedure vitesse();
function menuCantine():Integer;

implementation

var
   pos : coordonnees;

function menuCantine():Integer;
var
   f:Integer;
begin
  effacerEcran();
  dessinerCadreXY(30,5,85,25,simple,255,0);
  pos.x := 35;
  pos.y := 7;
  ecrireEnPosition(pos, 'Que voulez-vous manger : ');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '1)BOOST defense : Risoto au champi vitalis : 15');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '2)BOOST degats : soupe de corne de dragon : 20');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '3)BOOST vie : viande grillee : 12');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '4)BOOST vitesse : saute de pimants : 10');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '5)Retour a la ville : ');
  pos.x := 50;
  pos.y := 24;
  ecrireEnPosition(pos, 'Choix : ');
  readln(f);
  menuCantine:=f;
end;

procedure defense();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 45;
  pos.y := 13;
  ecrireEnPosition(pos, 'Vous avez un boost de 5 en defense ');
  readln(k);
  if (k = '')then cantine()
  else defense();
end;

procedure degats();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 45;
  pos.y := 13;
  ecrireEnPosition(pos, 'Vous avez un boost de 3 en degats ');
  readln(k);
  if (k = '')then cantine()
  else degats();
end;

procedure vie();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 48;
  pos.y := 13;
  ecrireEnPosition(pos, 'Vous avez un coeur en plus ');
  readln(k);
  if (k = '')then cantine()
  else vie();
end;

procedure vitesse();
var
   k:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 40;
  pos.y := 13;
  ecrireEnPosition(pos, 'Vous pouvez vous deplasser 1,5 fois plus vite ');
  pos.x := 50;
  pos.y := 14;
  ecrireEnPosition(pos, 'pendant 2 minutes ');
  readln(k);
  if (k = '')then cantine()
  else vitesse();
end;
end.

