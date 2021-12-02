unit uniteChasse;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage,outils, menu, uniteforge;

function chasser():Integer;
procedure menucombat(monster:monstre);
function quiAttaque(monster:monstre):monstre;
procedure drawHP(monster:monstre);
procedure drawHPBar(monster:monstre);
procedure drawTour(monster:monstre);
function aleaDegat(monster:monstre):Integer;
procedure reward(monster:monstre);

implementation

var
   pos : coordonnees;
   atk: Integer;

// cette fonction demande au joueur de choisir quel monstre il veut combattre
function chasser():Integer;

var

   select:Integer;

begin
  effacerEcran();
  dessinerCadreXY(30,3,90,25,double,255,0);
  pos.x := 43;
  pos.y := 5;
  deplacerCurseurXY(pos.x, pos.y);
  write('Bonne chance pour cette chasse ', getpseudo);
  pos.x := 45;
  pos.y := 12;
  ecrireEnPosition(pos, 'Niveau de dificulte : *');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'Niveau de dificulte : **');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'Niveau de dificulte : BOSS');
  pos.x := pos.x;
  pos.y := pos.y+2;
  ecrireEnPosition(pos, 'Retour a la ville ');
  pos.x := 54;
  pos.y := 24;
  ecrireEnPosition(pos, 'Choix : ');

  readln(select);
  if select=1 then
     begin
            menucombat(tabMonstre[0]);
     end
  else if select=2 then
     begin
            menucombat(tabMonstre[1]);
     end
  else if select=3 then
     begin
            menucombat(tabMonstre[2]);
     end
  else if select=4 then
     begin
            pieces();
     end;

end;

// cette procedure permet au joueur de combatre
procedure menucombat(monster:monstre);

var

   first:byte;

begin

  effacerEcran();
  deplacerCurseurXY(45,12);
  writeln('Vous rencontrez un ',monster.nom,' sauvage.');
  ReadLn;

  effacerEcran();
  dessinerCadreXY(2,19,46,28,simple,White,Black);

  deplacerCurseurXY(4,20);
  WriteLn('HP : ');

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

  dessinerCadreXY(25,25,42,27,simple,White,Black);
  pos.x:=32;
  pos.y:=26;
  ecrireEnPosition(pos,'Fuir');

  deplacerCurseurXY(68,1);
  WriteLn('HP : ');

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

  pos.x:=53;
  pos.y:=12;

  if getHeart()=0 then
     begin
          ecrireEnPosition(pos,'Vous avez perdu');
          readln;
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

   choix:Integer;
   fuir:Integer;

begin

  if atk=0 then
     begin

          drawTour(monster);

          readln(choix);
              if choix=1 then
                 begin
                          monster.hp:=monster.hp-50;
                          atk:=1;
                          quiAttaque:=monster;
                 end
              else if choix=2 then
                 begin
                          removeHeart(aleaDegat(monster) div 2);
                          atk:=1;
                          drawTour(monster);
                          atk:=0;
                          quiAttaque:=monster;
                 end
              else if choix=3 then
                 inventaire()
              else if choix=4 then
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
          write('             ');
          deplacerCurseurXY(0,2);
     end
  else if atk=1 then
     begin
          writeln('Tour du ', monster.nom,'                 ');
          writeln('               ');
          writeln('              ');
          attendre(600);
     end;

end;

procedure reward(monster:monstre);

var

   nbobj:Integer;
   randomobj:Integer;
   obj:item;
   countobj:Integer;
   randomMoney:Integer;

begin

  Randomize;

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
                             writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);
                         end;
                       2:
                         begin
                             obj.id:=tabProduits[3].id;
                             obj.count:=countobj;
                             writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[1].nom);
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

                  writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

                  obj.id:=tabProduits[3].id;
                  countobj:=random(3)+1;
                  obj.count:=countobj;
                  addItemInventory(obj);

                  writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);
             end;
          randomMoney:=random(7)+1;
          addMoney(randomMoney);
          writeln('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
     end
  else if monster.niveau=2 then
     begin
          obj.id:=tabProduits[0].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

          obj.id:=tabProduits[3].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);

          obj.id:=tabProduits[1].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[1].nom);

          randomMoney:=random(14)+1;
          addMoney(randomMoney);
          writeln('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
     end
  else
      begin
          obj.id:=tabProduits[0].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[0].nom);

          obj.id:=tabProduits[3].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[3].nom);

          obj.id:=tabProduits[1].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[1].nom);

          obj.id:=tabProduits[2].id;
          countobj:=random(3)+1;
          obj.count:=countobj;
          addItemInventory(obj);

          writeln('Vous avez obtenu ', obj.count, ' ', tabProduits[2].nom);

          randomMoney:=random(21)+1;
          addMoney(randomMoney);
          writeln('Vous avez trouve ', randomMoney, ' sous sur le monstre.');
      end;
  readln;

  pieces();

end;

end.

