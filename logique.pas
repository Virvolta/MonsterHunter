unit logique;

{$mode objfpc}{$H+}

interface

procedure start();
procedure pieces();
procedure chambre();
procedure cantine();
procedure marchand();
procedure vente(index:integer);
procedure armoire();
procedure inventaire();
procedure achat();
procedure validationAchat(index:integer);
procedure forge();
procedure valideVente(index:integer);

implementation
uses
  Classes, SysUtils, menu,uniteCantine,uniteChambre,uniteMarchand,uniteforge
  ,uniteChasse, outils, personnage;

// cette procedure fait marcher tout le jeu
procedure start();
begin
  ParseFile('json/objets.json','objets');
  ParseFile('json/equipements.json','equipements');
  ParseFile('json/monstre.json','monstres');
  case menuPrincipal() of
       1: menuPerso();
       2:
         begin
           menuHistoire();
           start();
         end;
       3: menuQuitter();
  else start()
  end;
end;

// cette procedure permet de choir dans quel pieces ont veut aller
procedure pieces();
begin
  setHeart(200);
  case menuJeu() of
       7: chambre();
       //2: forge();
       4: marchand();
       3: cantine();
       6: chasser();
  else pieces()
  end;
end;

// c'est la chambre
procedure chambre();
begin
  case menuChambre() of
       1: menuLit;
       2: armoire;
       3: pieces();
  else chambre()
  end;
end;

// c'est l'armoire
procedure armoire();
begin
  case menuArmoire() of
       1: chambre();
  end;
end;

procedure cantine();
begin
  case menuCantine() of
       1: defense;
       2: degats;
       3: vie;
       4: vitesse;
       5: pieces();
  else cantine();
  end;
end;

// c'est le marchand
procedure marchand();
begin
  case menuMarchand() of
       1: vente(0);
       2: achat;
       3: pieces();
  else marchand()
  end;
end;

// permet d'acheter des objets
procedure achat();
begin
  case menuAchat() of
       1: validationAchat(0);
       2: validationAchat(1);
       3: validationAchat(2);
       4: validationAchat(3);
       5: validationAchat(4);
       6: validationAchat(5);
       7: validationAchat(6);
       8: marchand();
  else achat()
  end;
end;

// confirmer l'achat
procedure validationAchat(index:integer);
begin
  case potion(index) of
       1: Oui(index);
       2: achat();
  else validationAchat(index)
  end;
end;

// vendre des objets
procedure vente(index:integer);
begin
  case menuVente() of
       1: inventaire();
       2: valideVente(index);
       3: marchand();
  else vente(index)
  end;
end;

// confirmer la vente
procedure valideVente(index:integer);
begin
  case validationVente(index) of
       4: UI(index);
       5: vente(index);
  else valideVente(index)
  end;
end;

// c'est l'inventaire
procedure inventaire();
begin
  case menuInventaire of
       21: vente(0);
  else inventaire()
  end;
end;

// c'est la forge
procedure forge();
var

  item1,item2:item;
  i:integer;
  j:integer;
  k:integer;
  m:integer;

begin

  for i:=1 to 4 do
    for m:=1 to 4 do
      for j:=1 to 8 do
          for k:=1 to 8 do
            begin
              item1.id:=i;
              item1.count:=j;
              item2.id:=m;
              item2.count:=k;

              writeln(item1.id,' (',item1.count,')','  +  ',item2.id,' (',item2.count,') ',' = ', getCraftResult(item1,item2).id);

            end;

  {item1.id:=1;
  item1.count:=1;
  item2.id:=1;
  item2.count:=1;

  res.id:=getCraftResult(item1,item2).id;
  res.count:=getCraftResult(item1,item2).count;
  writeln(getCraftResult(item1,item2).id);}

  {case menuForge() of
       1: menuInventaire();
       2: getCraftResult(item1,item2);
  end;}
end;

end.

