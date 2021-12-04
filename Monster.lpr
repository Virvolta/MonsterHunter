program Monster;

uses menu, IHM, logique, uniteCantine, uniteChambre, uniteMarchand,
  controle, uniteforge, personnage, uniteChasse, outils;

var
  i : item;

begin
  start();


  //cantine();
  //forge();
  //chasser();
  {i.id := 1;
  i.count := 2;
  addItemInventory(i);
  i.id := 3;
  i.count := 3;
  addItemInventory(i);
  i.id := 1;
  i.count := 5;
  addItemInventory(i);
  i.id := 4;
  i.count := 64;
  addItemInventory(i);
  i.id := 2;
  i.count := 3;
  addItemInventory(i);
  removeItemInventory(1,5);
  menuArmoire();
  pieces();}


  readln();
end.
