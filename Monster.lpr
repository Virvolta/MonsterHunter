program Monster;

uses menu, IHM, logique, uniteCantine, uniteChambre, uniteMarchand,
  controle, uniteforge, personnage, uniteChasse, outils;

var

  mon:monstre;

begin
  //start();
  setHeart(MAX_HEART);
  mon.niveau:=1;
  mon.nom:='Billy';
  mon.hp:=150;
  mon.degatmin:=10;
  mon.degatmax:=20;
  mon.defensemin:=20;
  mon.defensemax:=30;
  menucombat(mon);
  readln();
end.
