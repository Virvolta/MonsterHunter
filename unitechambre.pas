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
  ascii('lit', 0, 0);
  pos.x := 52;
  pos.y := 3;
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
   arm : TypeArmoire;
   pos : coordonnees;
   it : Item;
   select,select2 : Integer;
   ch : char;
   count,count2 : Integer;
   posinv : array[0..NOMBRE_INV_JEU] of Integer;
   posarm : array[0..NOMBRE_ARMOIRE_JEU] of Integer;
   inventory : boolean;

begin
  effacerEcran();
  inventory := true;
  select := 1;
  couleurs(15, 0);
  ascii('armoire', 0, 0);
  pos.x := 3;
  pos.y := 2;
  count := 0;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0) or (it.count > 0)) then
           begin
              if (select = i) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              count := count + 1;
              posinv[count] := i;
              ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := pos.y + 1;
           end;
      end;
  pos.x := 70;
  pos.y := 2;
  count2 := 0;
  arm := getArmoire();
    for i := Low(arm) to High(arm) do
      begin
        it := getItemArmoire(i);
        if ((it.id > 0) or (it.count > 0)) then
           begin
              count2 := count2 + 1;
              posarm[count2] := i;
              ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := pos.y + 1;
           end;
      end;
  couleurs(15, 0);
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'M','K':
      begin
        select := 1;
        pos.x := 3;
        pos.y := 2;
        for i := Low(inv) to High(inv) do
        begin
        it := getItemInventory(i);
        if ((it.id > 0) or (it.count > 0)) then
           begin
              ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := pos.y + 1;
           end;
        end;
        pos.x := 70;
        pos.y := 2;
        for i := Low(arm) to High(arm) do
        begin
        it := getItemArmoire(i);
        if ((it.id > 0) or (it.count > 0)) then
           begin
              ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := pos.y + 1;
           end;
        end;
        if (inventory = true) then
           inventory := false
        else
           inventory := true;
      end;
      'P':
      begin
        if (inventory = true) then
          begin
             select := select + 1;
             if (select > count + 1) then
             select := 1
          end
        else
          begin
             select := select + 1;
             if (select > count2 + 1) then
             select := 1
          end  ;
      end;
      'H':
      begin
        if (inventory = true) then
          begin
           select := select - 1;
           if (select <= 0) then
              select := count + 1;
          end
        else
          begin
           select := select - 1;
           if (select <= 0) then
              select := count2 + 1;
          end;
      end;
    end;
    if (inventory = true) then
      begin
        if (count + 1 = select) then
            begin
               couleurs(0, 15);
               pos.x := 58;
               pos.y := 27;
               ecrireEnPosition(pos, 'Menu');
               couleurs(15, 0);
            end
        else
            begin
                couleurs(15, 0);
                pos.x := 58;
                pos.y := 27;
                ecrireEnPosition(pos, 'Menu');
            end
         ;
         pos.x := 3;
         pos.y := 2;
         for i := Low(inv) to High(inv) do
           begin
             it := getItemInventory(i);
             if ((it.id > 0) or (it.count > 0)) then
                begin
                     if (select = i) then
                        couleurs(0, 15)
                     else
                         couleurs(15, 0)
                     ;
                     ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
                     pos.y := pos.y + 1;
                end;
             end;
         end
    else
      begin
         if (count2 + 1 = select) then
            begin
               couleurs(0, 15);
               pos.x := 58;
               pos.y := 27;
               ecrireEnPosition(pos, 'Menu');
               couleurs(15, 0);
            end
        else
            begin
                couleurs(15, 0);
                pos.x := 58;
                pos.y := 27;
                ecrireEnPosition(pos, 'Menu');
            end
         ;
         pos.x := 70;
         pos.y := 2;
         for i := Low(arm) to High(arm) do
           begin
             it := getItemArmoire(i);
             if ((it.id > 0) or (it.count > 0)) then
                begin
                     if (select = i) then
                        couleurs(0, 15)
                     else
                         couleurs(15, 0)
                     ;
                     ecrireEnPosition(pos, concat(tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
                     pos.y := pos.y + 1;
                end;
             end;
      end
    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;

  couleurs(0, 15);
  pos.x := 3;
  pos.y := 24;
  ecrireEnPosition(pos, 'Utiliser/Equiper');
  couleurs(15, 0);
  pos.x := 3;
  pos.y := 25;
  ecrireEnPosition(pos, 'Deplacer');
  pos.x := 3;
  pos.y := 26;
  ecrireEnPosition(pos, 'Suprimer');
  pos.x := 3;
  pos.y := 27;
  ecrireEnPosition(pos, 'Anuler');
  deplacerCurseurXY(0, 0);
  select2 := 1;
  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select2 := select2 + 1;
        if (select2 >= 5) then
          select2 := 1;
      end;
      'H':
      begin
        select2 := select - 1;
        if (select2 <= 0) then
          select2 := 4;
      end;
    end;

    case select2 of
      1:
      begin
        couleurs(0, 15);
        pos.x := 3;
        pos.y := 24;
        ecrireEnPosition(pos, 'Utiliser/Equiper');
        couleurs(15, 0);
        pos.x := 3;
        pos.y := 25;
        ecrireEnPosition(pos, 'Deplacer');
        pos.x := 3;
        pos.y := 26;
        ecrireEnPosition(pos, 'Suprimer');
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Anuler');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 3;
        pos.y := 25;
        ecrireEnPosition(pos, 'Deplacer');
        couleurs(15, 0);
        pos.x := 3;
        pos.y := 24;
        ecrireEnPosition(pos, 'Utiliser/Equiper');
        pos.x := 3;
        pos.y := 26;
        ecrireEnPosition(pos, 'Suprimer');
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Anuler');
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 3;
        pos.y := 26;
        ecrireEnPosition(pos, 'Suprimer');
        couleurs(15, 0);
        pos.x := 3;
        pos.y := 25;
        ecrireEnPosition(pos, 'Deplacer');
        pos.x := 3;
        pos.y := 24;
        ecrireEnPosition(pos, 'Utiliser/Equiper');
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Anuler');
        deplacerCurseurXY(0, 0);
      end;
      4:
      begin
        couleurs(0, 15);
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Anuler');
        couleurs(15, 0);
        pos.x := 3;
        pos.y := 26;
        ecrireEnPosition(pos, 'Suprimer');
        pos.x := 3;
        pos.y := 25;
        ecrireEnPosition(pos, 'Deplacer');
        pos.x := 3;
        pos.y := 24;
        ecrireEnPosition(pos, 'Utiliser/Equiper');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  //inventory
  //posinv[select];
  //posarm[select];
  readln();
  menuArmoire:=select;
end;

end.

