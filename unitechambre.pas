unit uniteChambre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique, outils, controle, personnage, uniteforge;

function menuChambre():Integer;
procedure menuLit();
function menuArmoire():Integer;

implementation

var
   pos : coordonnees;

// cette fonction sert a afficher la chambre
function menuChambre():Integer;
var
   select : Integer;
   ch : char;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('chambre', 0, 0);
  couleurs(0, 15);
  pos.x := 23;
  pos.y := 23;
  ecrireEnPosition(pos, 'Lit'); 
  couleurs(15, 0);
  pos.x := 90;
  pos.y := 23;
  ecrireEnPosition(pos, 'Armoire');
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
        select := 1;
      end;
      'M':
      begin
        select := 2;
      end;
      'P':
      begin
        if (select <> 3) then
           select := 3;
      end;
      'H':
      begin
        if (select = 3) then
           select := 1;
      end;
    end;
    case select of
      1:
      begin
           couleurs(0, 15);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Lit');
           couleurs(15, 0);
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Armoire');
           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           deplacerCurseurXY(0, 0);
      end;
      2:
      begin
           couleurs(0, 15);
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Armoire');
           couleurs(15, 0);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Lit');
           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           deplacerCurseurXY(0, 0);
      end;
      3:
      begin
           couleurs(0, 15);
           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           couleurs(15, 0);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Lit');
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Armoire');
           deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuChambre := select;
end;

// cette procedure permet au personnage de se reposer
procedure menuLit();
var
   e:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,double,255,0);
  pos.x := 58;
  pos.y := 13;
  ecrireEnPosition(pos, 'Bonne nuit');
  readln(e);
  if (e = '')then chambre()
  else menuLit();
end;

// cette fonction affiche l'armoire de la chambre
function menuArmoire():Integer;
var
   i:Integer;
   inv : TypeInventaire;
   pos : coordonnees;
   it : Item;
   select : Integer;
   ch : char;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('armoire', 0, 0);
  pos.x := 3;
  pos.y := 1;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0) or (it.count > 0)) then
           begin
              ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := pos.y + 1;
           end;
      end;
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
  until ch = #13;
  menuArmoire:=select;
end;

end.

