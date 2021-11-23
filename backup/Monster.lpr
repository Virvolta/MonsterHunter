program Monster;

uses menu, IHM, logique, uniteCantine, uniteChambre, uniteMarchand, controller,
  controle, uniteforge;

var
  item1, item2 : item;

begin
  item1.id := 1;
  item1.count := 2;
  item2.id := 2;
  item2.count := 1;
  writeln(getCraftResult(item1, item2).id);
  //start();
  readln();
end.

