unit uniteChambre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique, outils, controle, personnage, uniteforge;

function menuChambre():Integer;
procedure menuLit();
function menuArmoire() : Integer;

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

// cette fonction affiche le menu de l'armoire de la chambre
function menuArmoire() : Integer;
var
   i:Integer;
   inv : TypeInventaire;
   arm : TypeArmoire;
   pos : coordonnees;
   it : Item;
   select,select2 : Integer;
   ch : char;
   countmax, countmax2 : Integer;

   posinv : TypeInventaire;
   posarm : TypeArmoire;

   inventory,stop : boolean;

begin
  effacerEcran();
  inventory := true;
  select := 1;
  couleurs(15, 0);
  ascii('armoire', 0, 0);
  pos.x := 4;
  pos.y := 2;
  countmax := 0;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0)) then
           begin
              countmax := countmax + 1;
              posinv[countmax] := it;
              if (select = countmax) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax;
           end;
      end;
  couleurs(15, 0);
  pos.x := 72;
  pos.y := 2;
  countmax2 := 0;
  arm := getArmoire();
    for i := Low(arm) to High(arm) do
      begin
        it := getItemArmoire(i);
        if ((it.id > 0)) then
           begin
              countmax2 := countmax2 + 1;
              posarm[countmax2] := it;
              ecrireEnPosition(pos, concat(InttoStr(countmax2) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax2;
           end;
      end;
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
    case ch of
      'M','K':
      begin
        select := 1;
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
             if (select > countmax + 1) then
             select := 1
          end
        else
          begin
             select := select + 1;
             if (select > countmax2 + 1) then
             select := 1
          end;
      end;
      'H':
      begin
        if (inventory = true) then
          begin
           select := select - 1;
           if (select <= 0) then
              select := countmax + 1;
          end
        else
          begin
           select := select - 1;
           if (select <= 0) then
              select := countmax2 + 1;
          end;
      end;
    end;
    pos.x := 4;
  pos.y := 2;
  countmax := 0;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0)) then
           begin
              countmax := countmax + 1;
              posinv[countmax] := it;
              if ((select = countmax) and (inventory = true)) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax;
           end;
      end;
  couleurs(15, 0);
  pos.x := 72;
  pos.y := 2;
  countmax2 := 0;
  arm := getArmoire();
    for i := Low(arm) to High(arm) do
      begin
        it := getItemArmoire(i);
        if ((it.id > 0)) then
           begin
              countmax2 := countmax2 + 1;
              posarm[countmax2] := it;
              if ((select = countmax2) and (inventory = false)) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              ecrireEnPosition(pos, concat(InttoStr(countmax2) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax2;
           end;
      end;
    if (((select = countmax + 1) and (inventory = true)) or ((select = countmax2 + 1) and (inventory = false))) then
       begin
          couleurs(0, 15);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')
       end
    else
        begin
          couleurs(15, 0);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')
        end;

    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;
  stop := false;
  if (inventory = true) then
     begin
      if (select = countmax + 1) then
         begin
             stop := true;
             menuArmoire := 1;
         end
      end
  else
      begin
         if (select = countmax2 + 1) then
             begin
                 stop := true;
                 menuArmoire := 1;
             end
      end
  ;

  if (stop = false) then
     begin
        menuArmoire := 2;
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
        if (select2 > 4) then
          select2 := 1;
      end;
      'H':
      begin
        select2 := select2 - 1;
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
  if (inventory = true) then
    begin
      case select2 of
        1:
        begin
            {if (tabIdEquipments[it.id] = 0) then
              ;}
        end;
        2:
        begin
           it := posinv[select];
           removeItemInventory(it.id, it.count);
           addItemArmoire(it);
        end;
        3:
        begin
           it := posinv[select];
           removeItemInventory(it.id, it.count);
        end;
        4:
        begin
            //ANULER
        end;
      end;
    end
  else
    begin
      case select2 of
        1:
        begin
            //UTILISER
        end;
        2:
        begin
           it := posarm[select];
           removeItemArmoire(it.id, it.count);
           addItemInventory(it);
        end;
        3:
        begin
            it := posarm[select];
           removeItemArmoire(it.id, it.count);
        end;
        4:
        begin
            //ANULER
        end;
      end;
    end
  ;
  end;
end;

end.

