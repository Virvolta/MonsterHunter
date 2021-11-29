program Monster;

uses menu, IHM, logique, uniteCantine, uniteChambre, uniteMarchand,
  controle, uniteforge, personnage, uniteChasse, outils;

begin
  ParseFile('json/objets.json','objets');
  ParseFile('json/equipements.json','equipements');
  ParseFile('json/equipements.json','lol');
  start();
  menuJeu();
  readln();
end.
