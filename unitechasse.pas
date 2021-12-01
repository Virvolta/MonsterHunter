unit uniteChasse;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage,outils,menu;

function chasser():Integer;
procedure menucombat(monster:monstre);
function quiAttaque(monster:monstre):monstre;
procedure drawHP(monster:monstre);
procedure drawTour(monster:monstre);
function aleaDegat(monster:monstre):Integer;

implementation

var
   pos : coordonnees;
   atk: Integer;

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

procedure menucombat(monster:monstre);

var

   first:byte;

begin

  effacerEcran();
  deplacerCurseurXY(45,12);
  writeln('Vous rencontrez un ',monster.nom,' sauvage.');
  ReadLn;

  effacerEcran();
  dessinerCadreXY(2,19,42,28,simple,White,Black);

  deplacerCurseurXY(4,20);
  WriteLn('HP : ');
  ColorierZone(Green,Black,4,40,21);

  dessinerCadreXY(4,22,21,24,simple,White,Black);
  pos.x:=9;
  pos.y:=23;
  ecrireEnPosition(pos,'Attaquer');
  Write('');

  dessinerCadreXY(23,22,40,24,simple,White,Black);
  pos.x:=28;
  pos.y:=23;
  ecrireEnPosition(pos,'Defendre');

  dessinerCadreXY(4,25,21,27,simple,White,Black);
  pos.x:=8;
  pos.y:=26;
  ecrireEnPosition(pos,'Inventaire');

  dessinerCadreXY(23,25,40,27,simple,White,Black);
  pos.x:=30;
  pos.y:=26;
  ecrireEnPosition(pos,'Fuir');

  deplacerCurseurXY(68,1);
  WriteLn('HP : ');
  ColorierZone(Magenta,Black,54,90,2);


  randomize();
  first:=Random(2);

  drawHP(monster);

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
          pieces();
     end;

end;

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

end;

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

end.

