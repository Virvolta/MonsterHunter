unit uniteChambre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,GestionEcran, outils, controle, personnage;

function menuChambre():Integer;
function menuLit():Integer;
function menuArmoire() : Integer;

implementation

// cette fonction sert a afficher la chambre
function menuChambre():Integer;

var

   select : Integer;
   ch : char;
   pos: coordonnees;

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
      'K':select := 1;
      'M':select := 2;
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

// cette fonction permet au personnage de se reposer
function menuLit() : Integer;

var

   pos: coordonnees;
   ch : char;

begin

  effacerEcran();
  setHeart(MAX_HEART);
  ascii('lit', 0, 0);
  pos.x := 52;
  pos.y := 3;
  ecrireEnPosition(pos, 'Bonne nuit');

  repeat
    ch := ReadKey;
  until ch = #13;

  menuLit := 1;

end;

// cette fonction affiche le menu de l'armoire de la chambre
function menuArmoire() : Integer;

var

   i:Integer;
   inv,posinv : TypeInventaire;
   arm,posarm  : TypeArmoire;
   equ : TypeEquipement;
   posequ : array[0..6] of Integer;
   pos : coordonnees;
   it : Item;
   select,select2,inventory : Integer;
   ch : char;
   countmax, countmax2, countmax3 : Integer;
   stop : boolean;

begin

  effacerEcran();
  inventory := 1;
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

               if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)))
               else
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)))
               ;

              pos.y := 2 + countmax;

           end;
      end;

  couleurs(15, 0);
  pos.x := 43;
  pos.y := 2;

  countmax2 := 0;
  equ := getEquipement();

  for i := Low(equ) to High(equ) do
    begin

        it := getItemEquipement(i);

        if ((it.id > 0)) then
           begin

              countmax2 := countmax2 + 1;
              posequ[countmax2] := i;
              ecrireEnPosition(pos, concat(InttoStr(countmax2) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax2;

           end;

      end;

  pos.x := 83;
  pos.y := 2;

  countmax3 := 0;
  arm := getArmoire();

  for i := Low(arm) to High(arm) do
    begin

        it := getItemArmoire(i);

        if ((it.id > 0)) then
           begin

              countmax3 := countmax3 + 1;
              posarm[countmax3] := it;

              if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                ecrireEnPosition(pos, concat(InttoStr(countmax3) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)))
              else
                 ecrireEnPosition(pos, concat(InttoStr(countmax3) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)))
              ;

              pos.y := 2 + countmax3;

           end;
      end;

  if (((select = countmax + 1) and (inventory = 1)) or ((select = countmax2 + 1) and (inventory = 2)) or ((select = countmax3 + 1) and (inventory = 3))) then
    begin

        couleurs(0, 15);

        pos.x := 58;
        pos.y := 27;
        ecrireEnPosition(pos, 'Menu');

    end
  else
    begin

       couleurs(15, 0);

       pos.x := 58;
       pos.y := 27;
       ecrireEnPosition(pos, 'Menu');

    end;

  ;

  couleurs(15, 0);
  deplacerCurseurXY(0, 0);

  repeat

    ch := ReadKey;

    case ch of
      'M' :
       begin

           select := 1;
           inventory := inventory + 1;

           if (inventory > 3) then
                inventory := 1
           ;

       end;
      'K':
       begin

           select := 1;
           inventory := inventory - 1;

           if (inventory <= 0) then
               inventory := 3
           ;

       end;
      'P':
       begin

           if (inventory = 1) then
             begin

                 select := select + 1;

                 if (select > countmax + 1) then
                     select := 1
                 ;

             end
           else if (inventory = 2) then
             begin

                 select := select + 1;

                 if (select > countmax2 + 1) then
                     select := 1
                 ;

             end
           else if (inventory = 3) then
             begin

                 select := select + 1;

                 if (select > countmax3 + 1) then
                     select := 1
                 ;
             end
           ;
       end;
      'H':
       begin

         if (inventory = 1) then
           begin

               select := select - 1;

               if (select <= 0) then
                   select := countmax + 1
               ;

          end
        else if (inventory = 2) then
          begin

              select := select - 1;

              if (select <= 0) then
                  select := countmax2 + 1
              ;

          end
        else if (inventory = 3) then
          begin

              select := select - 1;
              if (select <= 0) then
                  select := countmax3 + 1
              ;

          end
        ;
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

              if ((select = countmax) and (inventory = 1)) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;

              if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)))
              else
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)))
              ;

              pos.y := 2 + countmax;

           end;
      end;

  couleurs(15, 0);
  pos.x := 43;
  pos.y := 2;

  countmax2 := 0;
  equ := getEquipement();

  for i := Low(equ) to High(equ) do
    begin

        it := getItemEquipement(i);

        if ((it.id > 0)) then
           begin

              countmax2 := countmax2 + 1;
              posequ[countmax2] := i;

              if ((select = countmax2) and (inventory = 2)) then
                  couleurs(0, 15)
              else
                  couleurs(15, 0)
              ;

              ecrireEnPosition(pos, concat(InttoStr(countmax2) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax2;

           end;
      end;

  pos.x := 83;
  pos.y := 2;

  countmax3 := 0;
  arm := getArmoire();
  for i := Low(arm) to High(arm) do
    begin

        it := getItemArmoire(i);

        if ((it.id > 0)) then
           begin

              countmax3 := countmax3 + 1;
              posarm[countmax3] := it;

              if ((select = countmax3) and (inventory = 3)) then
                  couleurs(0, 15)
              else
                  couleurs(15, 0)
              ;

              if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                  ecrireEnPosition(pos, concat(InttoStr(countmax3) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)))
              else
                  ecrireEnPosition(pos, concat(InttoStr(countmax3) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)))
              ;

              pos.y := 2 + countmax3;

           end;
      end;

    if (((select = countmax + 1) and (inventory = 1)) or ((select = countmax2 + 1) and (inventory = 2)) or ((select = countmax3 + 1) and (inventory = 3))) then
       begin

           couleurs(0, 15);

           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');

       end
    else
        begin

          couleurs(15, 0);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu');

        end;

    ;

    couleurs(15, 0);
    deplacerCurseurXY(0, 0);

  until ch = #13;

  stop := false;

  if (inventory = 1) then
     begin

       if (select = countmax + 1) then
         begin

             stop := true;
             menuArmoire := 1;

         end
      end
  else if (inventory = 2) then
     begin

       if (select = countmax2 + 1) then
         begin

             stop := true;
             menuArmoire := 1;

         end
      end
  else if (inventory = 3) then
      begin

         if (select = countmax3 + 1) then
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
        ecrireEnPosition(pos, 'Utiliser/Equiper/Desequiper');
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
                   ecrireEnPosition(pos, 'Utiliser/Equiper/Desequiper');
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
                   ecrireEnPosition(pos, 'Utiliser/Equiper/Desequiper');
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
                   ecrireEnPosition(pos, 'Utiliser/Equiper/Desequiper');
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
                   ecrireEnPosition(pos, 'Utiliser/Equiper/Desequiper');
                   deplacerCurseurXY(0, 0);
               end;
            end;
        until ch = #13;

        if (inventory = 1) then
          begin

              case select2 of
                1:
                 begin

                     it := posinv[select];
                     removeItemInventory(it.id, it.count);

                     if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                       begin

                           addItemInventory(getItemEquipement(tabEquipments[tabIdEquipments[it.id]].slot));
                           addItemEquipement(it);

                       end
                     ;
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
     else if (inventory = 2) then
       begin

           case select2 of
             1:
              begin
                  //UTILISER
              end;
             2:
              begin

                  it := getItemEquipement(posequ[select]);
                  removeItemEquipement(posequ[select]);
                  addItemArmoire(it);

              end;
             3: removeItemEquipement(posequ[select]);
             4:
              begin
                  //ANULER
              end;
           end;
       end
     else if (inventory = 3) then
       begin

           case select2 of
             1:
              begin

                  it := posarm[select];
                  removeItemArmoire(it.id, it.count);

                  if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                    begin

                        addItemArmoire(getItemEquipement(tabEquipments[tabIdEquipments[it.id]].slot));
                        addItemEquipement(it);
                    end
                  else
                    begin

                    end
                  ;
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

