program Monster;

uses menu, IHM, logique, uniteCantine, uniteChambre, uniteMarchand,
  controle, uniteforge;

var
  item1, item2 : item;

begin
  start();
  removeItemInventory();
  readln();
end.

