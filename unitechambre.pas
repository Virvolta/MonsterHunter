unit uniteChambre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique;

function menuChambre():Integer;
procedure menuLit();
function menuArmoire():Integer;

implementation

var
   pos : coordonnees;

function menuChambre():Integer;
var
   d : Integer;
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

procedure menuLit();
var
   e:string;
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

function menuArmoire():Integer;
var
   i:Integer;
begin
  effacerEtColorierEcran(6);
  dessinerCadreXY(2,2,50,25,simple,0,6);
  dessinerCadreXY(70,2,118,25,simple,0,6);
  dessinerCadreXY(2,27,118,29,simple,0,6);
  pos.x := 20;
  pos.y := 1;
  ecrireEnPosition(pos, 'Stockage ');
  pos.x := 90;
  pos.y := 1;
  ecrireEnPosition(pos, 'Inventaire');
  pos.x := 50;
  pos.y := 28;
  ecrireEnPosition(pos, '1)Retour a la chambre : ');
  readln(i);
  menuArmoire:=i;
end;

end.

