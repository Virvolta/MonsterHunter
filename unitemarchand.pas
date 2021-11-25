unit uniteMarchand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique;

function menuMarchand(): Integer;
function menuVente():Integer;
function menuAchat():Integer;
function potion() : Integer;
procedure Oui();
function validationVente():Integer;
procedure UI();

implementation

var
   pos : coordonnees;

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
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 93;
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
  pos.x := 3;
  pos.y := 1;
  ecrireEnPosition(pos, '2)Valider la vente');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(h);
  menuVente := h;

end;

function menuAchat():Integer;
var
   a:integer;
begin
  effacerEcran();
  dessinerCadreXY(20,3,100,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 50;
  pos.y := 1;
  ecrireEnPosition(pos, '8)Retour au menu marchand');
  pos.x := 52;
  pos.y := 4;
  ecrireEnPosition(pos, 'Acheter des objets : ');
  pos.x := 35;
  pos.y := 9;
  ecrireEnPosition(pos, '1) Potion de vie : 15');
  pos.x := 35;
  pos.y := 11;
  ecrireEnPosition(pos, '2) Potion de vie : (prix)');
  pos.x := 35;
  pos.y := 13;
  ecrireEnPosition(pos, '3) Potion de vie : (prix)');
  pos.x := 35;
  pos.y := 15;
  ecrireEnPosition(pos, '4) Potion de vie : (prix)');
  pos.x := 35;
  pos.y := 17;
  ecrireEnPosition(pos, '5) Potion de vie : (prix)');
  pos.x := 35;
  pos.y := 19;
  ecrireEnPosition(pos, '6) Potion de vie : (prix)');
  pos.x := 35;
  pos.y := 21;
  ecrireEnPosition(pos, '7) Potion de vie : (prix)');

  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(a);
  menuAchat := a;

end;

function potion() : Integer;
var
   p:Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,14,118,16,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  pos.x := 40;
  pos.y := 15;
  ecrireEnPosition(pos, 'Voulez vous vraiment acheter cette objet');
  pos.x := 30;
  pos.y := 28;
  ecrireEnPosition(pos, '1) Oui');
  pos.x := 80;
  pos.y := 28;
  ecrireEnPosition(pos, '2) Non');
  pos.x := 55;
  pos.y := 28;
  ecrireEnPosition(pos, 'choix : ');
  readln(p);
  potion := p;

end;

procedure Oui();
var
   e:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 43;
  pos.y := 13;
  ecrireEnPosition(pos, 'votre objet est dans votre inventaire');
  readln(e);
  if (e = '')then achat()
  else Oui();
end;

function validationVente():Integer;
var
   v:Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 93;
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
  pos.x := 3;
  pos.y := 1;
  ecrireEnPosition(pos, '2)Valider la vente');


  dessinerCadreXY(70,3,118,26,simple,255,0);
  pos.x := 75;
  pos.y := 4;
  ecrireEnPosition(pos, 'Voulez vous vraiment vendre cette objet');
  pos.x := 85;
  pos.y := 15;
  ecrireEnPosition(pos, 'Son prix est de (prix)');
  pos.x := 71;
  pos.y := 25;
  ecrireEnPosition(pos, '4)Oui');
  pos.x := 112;
  pos.y := 25;
  ecrireEnPosition(pos, '5)Non');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(v);
  validationVente := v;

end;

procedure UI();
var
   e:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 50;
  pos.y := 13;
  ecrireEnPosition(pos, 'votre objet est bien vendu');
  readln(e);
  if (e = '')then vente()
  else UI();
end;

end.

