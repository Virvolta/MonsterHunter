unit uniteChasse;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage;

function chasser():Integer;

implementation

var
   pos : coordonnees;

function chasser():Integer;
begin
  effacerEcran();
  dessinerCadreXY(30,3,90,25,double,255,0);
  pos.x := 43;
  pos.y := 5;
  deplacerCurseurXY(pos.x, pos.y);
  write('Bonne chance pour cette chasse ', getpseudo);
  pos.x := 45;
  pos.y := 12;
  ecrireEnPosition(pos, '1)Niveau de dificulte : *');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '2)Niveau de dificulte : **');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, '3)Niveau de dificulte : BOSS');
  pos.x := 54;
  pos.y := 24;
  ecrireEnPosition(pos, 'Choix : ');

end;

end.

