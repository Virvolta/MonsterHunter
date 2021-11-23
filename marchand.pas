unit marchand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function menuMarchand(): Integer;
function menuVente():Integer;
procedure menuAchat;

implementation

function menuMarchand(): Integer;
var
   g: integer;
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

function menuVente():Integer;
var
   h: integer;
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
  menuVente := h;

end;
procedure menuAchat;
begin

end;

end.

