unit uniteChasse;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage,outils,menu,controle,uniteforge;

function chasser():integer;
function menucombat(monster:monstre):integer;
function quiAttaque(monster:monstre):monstre;
procedure drawHP(monster:monstre);
procedure drawHPBar(monster:monstre);
procedure drawTour(monster:monstre);
function aleaDegat(monster:monstre):Integer;
procedure reward(monster:monstre);
function menuInventoryChasse() : Integer;

implementation

var
   pos : coordonnees;
   atk: Integer;

// cette fonction demande au joueur de choisir quel monstre il veut combattre
function chasser():integer;

var

   select:Integer;
   ch: char;
   i: integer;

begin
  setHeart(200);
  effacerEcran();
  couleurs(15, 0);
  pos.x := 43;
  pos.y := 5;
  deplacerCurseurXY(pos.x, pos.y);
  write('Bonne chance pour cette chasse ', getpseudo);
  couleurs(0, 15);
  pos.x := 45;
  pos.y := 12;
  ecrireEnPosition(pos, 'Niveau de difficulte : *');
  couleurs(15, 0);
  pos.x := 45;
  pos.y := 14;
  ecrireEnPosition(pos, 'Niveau de difficulte : **');
  pos.x := 45;
  pos.y := 16;
  ecrireEnPosition(pos, 'Niveau de difficulte : BOSS');
  pos.x := 45;
  pos.y := 18;
  ecrireEnPosition(pos, 'Retour a la ville ');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select >= 5) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 4;
      end;
    end;
    case select of
      1 :
      begin
        couleurs(0, 15);
        pos.x := 45;
        pos.y := 12;
        ecrireEnPosition(pos, 'Niveau de difficulte : *');
        couleurs(15, 0);
        pos.x := 45;
        pos.y := 14;
        ecrireEnPosition(pos, 'Niveau de difficulte : **');
        pos.x := 45;
        pos.y := 16;
        ecrireEnPosition(pos, 'Niveau de difficulte : BOSS');
        pos.x := 45;
        pos.y := 18;
        ecrireEnPosition(pos, 'Retour a la ville ');
        deplacerCurseurXY(0, 0);
      end;
      2 :
      begin
        couleurs(0, 15);
        pos.x := 45;
        pos.y := 14;
        ecrireEnPosition(pos, 'Niveau de difficulte : **');
        couleurs(15, 0);
        pos.x := 45;
        pos.y := 16;
        ecrireEnPosition(pos, 'Niveau de difficulte : BOSS');
        pos.x := 45;
        pos.y := 18;
        ecrireEnPosition(pos, 'Retour a la ville');
        pos.x := 45;
        pos.y := 12;
        ecrireEnPosition(pos, 'Niveau de difficulte : *');
        deplacerCurseurXY(0, 0);
      end;
      3 :
      begin
        couleurs(0, 15);
        pos.x := 45;
        pos.y := 16;
        ecrireEnPosition(pos, 'Niveau de difficulte : BOSS');
        couleurs(15, 0);
        pos.x := 45;
        pos.y := 18;
        ecrireEnPosition(pos, 'Retour a la ville');
        pos.x := 45;
        pos.y := 12;
        ecrireEnPosition(pos, 'Niveau de difficulte : *');
        pos.x := 45;
        pos.y := 14;
        ecrireEnPosition(pos, 'Niveau de difficulte : **');
        deplacerCurseurXY(0, 0);
      end;
      4 :
      begin
        couleurs(0, 15);
        pos.x := 45;
        pos.y := 18;
        ecrireEnPosition(pos, 'Retour a la ville');
        couleurs(15, 0);
        pos.x := 45;
        pos.y := 12;
        ecrireEnPosition(pos, 'Niveau de difficulte : *');
        pos.x := 45;
        pos.y := 14;
        ecrireEnPosition(pos, 'Niveau de difficulte : **');
        pos.x := 45;
        pos.y := 16;
        ecrireEnPosition(pos, 'Niveau de difficulte : BOSS');
        deplacerCurseurXY(0, 0);
      end;
    end;

  until ch = #13;
  chasser := select;

  case chasser of
    1 : menucombat(tabmonstre[0]);
    2 : menucombat(tabmonstre[1]);
    3 : menucombat(tabmonstre[2]);
    4 : pieces;
  end;

  end;

// cette procedure permet au joueur de combatre
function menucombat(monster:monstre):integer;

var

   first:byte;
   select:Integer;
   ch:Char;

begin

  effacerEcran();
  couleurs(15, 0);
  ascii('marchand_achat',0, 0);
  deplacerCurseurXY(45,12);
  couleurs(15,0);
  writeln('Vous rencontrez un ',monster.nom,' sauvage.');
  deplacerCurseurXY(0, 0);
  ReadLn;

  effacerEcran();
  dessinerCadreXY(2,19,46,28,simple,White,Black);

  deplacerCurseurXY(4,20);
  WriteLn('HP : ');

  deplacerCurseurXY(68,1);
  WriteLn('HP : ');

  dessinerCadreXY(6,22,23,24,simple,Black,White);
  couleurs(0, 15);
  pos.x:=11;
  pos.y:=23;
  ecrireEnPosition(pos,'Attaquer');

  couleurs(15, 0);
  dessinerCadreXY(25,22,42,24,simple,White,Black);
  pos.x:=30;
  pos.y:=23;
  ecrireEnPosition(pos,'Defendre');

  dessinerCadreXY(6,25,23,27,simple,White,Black);
  pos.x:=10;
  pos.y:=26;
  ecrireEnPosition(pos,'Inventaire');

  dessinerCadreXY(25,25,42,27,simple,White,Black);
  pos.x:=32;
  pos.y:=26;
  ecrireEnPosition(pos,'Fuir');
  deplacerCurseurXY(0, 0);

  drawHP(monster);

  randomize();
  first:=Random(2);

  if first=0 then
    monster:=quiAttaque(monster)
  else if first=1 then
     monster:=quiAttaque(monster);

  repeat

    drawHP(monster);

    if atk=0 then
       begin
           monster:=quiAttaque(monster);
       end
    else if atk=1 then
       begin
            monster:=quiAttaque(monster);
       end;

  until ((getHeart=0) or (monster.hp<=0));

  if monster.hp<=0 then
     begin
            monster.hp:=0;
            drawHP(monster);
     end
  else if (getHeart=0) then
      begin
           drawHP(monster);
      end;



  effacerEcran;
  couleurs(15,0);
  ascii('marchand_achat',0, 0);

  pos.x:=48;
  pos.y:=12;

  if getHeart()=0 then
     begin
          ecrireEnPosition(pos,'Vous avez perdu');
          readln;
          pieces();
     end
  else if monster.hp=0 then
     begin
          ecrireEnPosition(pos,'Vous avez gagne');
          readln;
          reward(monster);
     end;

end;

// cette fonction choisi qui attaque et veille a ce que les combatant joue chacun leur tour
function quiAttaque(monster:monstre):monstre;

var

   fuir:Integer;
   select: integer;
   ch: char;
   i: integer;

begin

  drawTour(monster);

  if atk=0 then
     begin

          select:=1;
          repeat
            ch := ReadKey;
            case ch of
              'K':
              begin
                select := select - 1;
                if (select <= 0) then
                  select := 4;
              end;
              'M':
              begin
                select := select + 1;
                if (select > 4) then
                  select := 1;
              end;
              'P':
              begin
                if (select <= 2) then
                   begin
                        case select of
                          1 : select := 3;
                          2 : select := 4;
                        end;
                   end;
              end;
              'H':
              begin
                if (select > 2) then
                   begin
                        case select of
                          3 : select := 1;
                          4 : select := 2;
                        end;
                   end;
              end;

            end;
            case select of
              1 :
              begin
                couleurs(0, 15);
                dessinerCadreXY(6,22,23,24,simple,Black,White);
                pos.x:=11;
                pos.y:=23;
                ecrireEnPosition(pos,'Attaquer');

                couleurs(15, 0);
                dessinerCadreXY(25,22,42,24,simple,White,Black);
                pos.x:=30;
                pos.y:=23;
                ecrireEnPosition(pos,'Defendre');

                dessinerCadreXY(6,25,23,27,simple,White,Black);
                pos.x:=10;
                pos.y:=26;
                ecrireEnPosition(pos,'Inventaire');

                dessinerCadreXY(25,25,42,27,simple,White,Black);
                pos.x:=32;
                pos.y:=26;
                ecrireEnPosition(pos,'Fuir');
                deplacerCurseurXY(0, 0);
              end;
              2 :
              begin
                couleurs(0, 15);
                dessinerCadreXY(25,22,42,24,simple,Black,White);
                pos.x:=30;
                pos.y:=23;
                ecrireEnPosition(pos,'Defendre');

                couleurs(15, 0);
                dessinerCadreXY(6,25,23,27,simple,White,Black);
                pos.x:=10;
                pos.y:=26;
                ecrireEnPosition(pos,'Inventaire');

                dessinerCadreXY(25,25,42,27,simple,White,Black);
                pos.x:=32;
                pos.y:=26;
                ecrireEnPosition(pos,'Fuir');

                dessinerCadreXY(6,22,23,24,simple,White,Black);
                pos.x:=11;
                pos.y:=23;
                ecrireEnPosition(pos,'Attaquer');
                deplacerCurseurXY(0, 0);
              end;
              3 :
              begin
                couleurs(0, 15);
                dessinerCadreXY(6,25,23,27,simple,Black,White);
                pos.x:=10;
                pos.y:=26;
                ecrireEnPosition(pos,'Inventaire');

                couleurs(15, 0);
                dessinerCadreXY(25,25,42,27,simple,White,Black);
                pos.x:=32;
                pos.y:=26;
                ecrireEnPosition(pos,'Fuir');

                dessinerCadreXY(6,22,23,24,simple,White,Black);
                pos.x:=11;
                pos.y:=23;
                ecrireEnPosition(pos,'Attaquer');

                dessinerCadreXY(25,22,42,24,simple,White,Black);
                pos.x:=30;
                pos.y:=23;
                ecrireEnPosition(pos,'Defendre');
                deplacerCurseurXY(0, 0);
              end;
              4 :
              begin
                couleurs(0, 15);
                dessinerCadreXY(25,25,42,27,simple,Black,White);
                pos.x:=32;
                pos.y:=26;
                ecrireEnPosition(pos,'Fuir');

                couleurs(15, 0);
                dessinerCadreXY(6,22,23,24,simple,White,Black);
                pos.x:=11;
                pos.y:=23;
                ecrireEnPosition(pos,'Attaquer');

                dessinerCadreXY(25,22,42,24,simple,White,Black);
                pos.x:=30;
                pos.y:=23;
                ecrireEnPosition(pos,'Defendre');

                dessinerCadreXY(6,25,23,27,simple,White,Black);
                pos.x:=10;
                pos.y:=26;
                ecrireEnPosition(pos,'Inventaire');
                deplacerCurseurXY(0, 0);
              end;
            end;
            until ch = #13;

          if select=1 then
             begin
                  monster.hp:=monster.hp-50;
                  atk:=1;
                  quiAttaque:=monster;
             end
          else if select=2 then
             begin
                  removeHeart(aleaDegat(monster) div 2);
                  atk:=1;
                  drawTour(monster);
                  atk:=0;
                  quiAttaque:=monster;
             end
          else if select=3 then
            inventaireChasse()
          else if select=4 then
             begin
                  Randomize;
                  fuir:=Random(2);
                  if fuir=0 then
                     begin
                          writeln('Vous ne pouvez pas fuir');
                          atk:=1;
                          quiAttaque:=monster;

                     end
                  else
                  pieces();
             end;
     end
  else if atk=1 then
     begin
          drawTour(monster);
          removeHeart(aleaDegat(monster));
          atk:=0;
          quiAttaque:=monster;
     end;

end;

// cette procedure dessine les HP du joueur et du monstre
procedure drawHP(monster:monstre);

var

   hp_joueur,hp_monstre:coordonnees;

begin

  hp_joueur.x:=9;
  hp_joueur.y:=20;

  hp_monstre.x:=74;
  hp_monstre.y:=1;

  ecrireEnPosition(hp_joueur,IntToStr(getHeart()) + '  ');
  ecrireEnPosition(hp_monstre,IntToStr(monster.hp) + '  ' + monster.nom + '   ');
  drawHPBar(monster);

end;

procedure drawHPBar(monster:monstre);

var

   i,j:Integer;

begin

  i:= round((getHeart / MAX_HEART) * 40)+4;
  j := round((monster.hp/tabMonstre[monster.niveau-1].hp)*50)+50;
  if getHeart=MAX_HEART then
     ColorierZone(Green,Black,4,44,21)
  else if getHeart<=(MAX_HEART/2) then
     begin
          ColorierZone(Red,Black,4,23,21);
          ColorierZone(LightGray,Black,i, 44,21);
     end
  else
      ColorierZone(LightGray,Black,i, 44,21);
  if monster.hp=tabMonstre[monster.niveau-1].hp then
     ColorierZone(Magenta,Black,50,100,2)
  else if monster.hp<=(tabMonstre[monster.niveau-1].hp/2) then
     begin
          ColorierZone(LightMagenta,Black, 50, 76,2);
          ColorierZone(LightGray,Black,j, 100,2);
     end
  else
    ColorierZone(LightGray,Black,j, 100,2);
end;

// cette fonction genere des degats aleatoire pour le monstre en degatmin et degatmax
function aleaDegat(monster:monstre):Integer;

var

   alea:Integer;

begin

  randomize;

  alea:=Random(2);

  case alea of
       0:aleaDegat:=monster.degatmin;
       1:aleaDegat:=monster.degatmax;
  end;

end;

// cette procedure affiche qui doit jouer
procedure drawTour(monster:monstre);

begin

  deplacerCurseurXY(0,0);

  if atk=0 then
     begin
          writeln('Tour de ', getPseudo(),'                ');
          writeln('Choisissez : ');
          writeln('              ');
     end
  else if atk=1 then
     begin
          writeln('Tour du ', monster.nom,'                 ');
          writeln('               ');
          writeln('              ');
          attendre(300);
     end;

end;

procedure reward(monster:monstre);

var

   nbobj:Integer;
   randomobj:Integer;
   obj:item;
   countobj:Integer;
   randomMoney:Integer;
   fin:integer;
   select: integer;
   ch: char;

begin

  Randomize;
  effacerEcran;
  couleurs(15,0);
  ascii('marchand_achat',0,0);

  if monster.niveau=1 then
     begin
          nbobj:=random(2)+1;

          if nbobj=1 then
             begin
                  randomobj:=random(2)+1;

                  countobj:=random(3)+1;

                  case randomobj of
                       1:
                         begin
                             obj.id:=tabProduits[0].id;
                             obj.count:=countobj;
                             deplacerCurseurXY(40,11);
                             write('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);
                             deplacerCurseurXY(0,0);
                         end;
                       2:
                         begin
                             obj.id:=tabProduits[3].id;
                             obj.count:=countobj;
                             deplacerCurseurXY(40,13);
                             write('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);
                             deplacerCurseurXY(0,0);
                         end;
                  end;
                  addItemInventory(obj);

             end
          else if nbobj=2 then
             begin
                  obj.id:=tabProduits[0].id;
                  countobj:=random(3)+1;
                  obj.count:=countobj;
                  addItemInventory(obj);
                  deplacerCurseurXY(40,11);
                  write('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

                  obj.id:=tabProduits[3].id;
                  countobj:=random(3)+1;
                  obj.count:=countobj;
                  addItemInventory(obj);
                  deplacerCurseurXY(40,13);
                  write('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);

             end;
          randomMoney:=random(7)+1;
          addMoney(randomMoney);
          deplacerCurseurXY(40,15);
          writeln('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
          deplacerCurseurXY(0,0);
     end
  else if monster.niveau=2 then
     begin
          obj.id:=tabProduits[0].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,9);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

          obj.id:=tabProduits[3].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,11);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);

          obj.id:=tabProduits[1].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,13);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[1].nom);

          randomMoney:=random(14)+1;
          addMoney(randomMoney);
          deplacerCurseurXY(40,15);
          write('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
          deplacerCurseurXY(0,0);
     end
  else
      begin
          obj.id:=tabProduits[0].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,9);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

          obj.id:=tabProduits[3].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,11);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);

          obj.id:=tabProduits[1].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,13);
          write('Vous avez obtenu ', obj.count, ' ', tabProduits[1].nom);

          obj.id:=tabProduits[2].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);
          deplacerCurseurXY(40,15);
          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[2].nom);

          randomMoney:=random(21)+1;
          addMoney(randomMoney);
          deplacerCurseurXY(40,17);
          write('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
          deplacerCurseurXY(0,0);
      end;
  readln;

  effacerEcran;
  couleurs(15,0);
  ascii('marchand_achat',0,0);
  pos.x := 40;
  pos.y := 2 ;
  ecrireEnPosition(pos, 'Voulez-vous refaire une chasse ?');
  couleurs(0,15);
  pos.x := 40;
  pos.y := 12;
  ecrireEnPosition(pos, 'Chasser a nouveau');
  couleurs(15,0);
  pos.x := 40;
  pos.y := 14;
  ecrireEnPosition(pos,'Retourner a la ville');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'H':
      begin
        select := select + 1;
        if (select >= 2) then
          select := 1;
      end;
      'P':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0,15);
        pos.x := 40;
        pos.y := 12;
        ecrireEnPosition(pos, 'Chasser a nouveau');
        couleurs(15,0);
        pos.x := 40;
        pos.y := 14;
        ecrireEnPosition(pos, 'Retourner a la ville');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0,15);
        pos.x := 40;
        pos.y := 14;
        ecrireEnPosition(pos, 'Retourner a la ville');
        couleurs(15,0);
        pos.x := 40;
        pos.y := 12;
        ecrireEnPosition(pos, 'Chasser a nouveau');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  fin := select;

  case fin of
    1 : chasser();
    2 : pieces();
  end;


end;

function menuInventoryChasse() : Integer;
var
   i:Integer;
   inv,posinv : TypeInventaire;
   posequ : array[0..NOMBRE_EQUIPEMENT_JEU] of Integer;
   pos : coordonnees;
   it : Item;
   select,select2 : Integer;
   ch : char;
   countmax : Integer;

begin
  effacerEcran();
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
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax;
           end;
      end;
  couleurs(15, 0);
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select > countmax + 1) then
            select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
            select := countmax + 1;
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
              if (select = countmax) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              if (tabEquipments[tabIdEquipments[it.id]].id = it.id) then
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabEquipments[tabIdEquipments[it.id]].nom, ' x', InttoStr(it.count)))
              else
                 ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));
              pos.y := 2 + countmax;
           end;
      end;
    couleurs(15, 0);
    if (select = countmax + 1) then
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
        end
    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;
  if (select = countmax + 1) then
      begin
          menuInventoryChasse := 1;
      end
  else
      begin
          menuInventoryChasse := 2;
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
            else
              begin

              end;
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
end;

end.

