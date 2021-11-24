unit logique;

{$mode objfpc}{$H+}

interface

procedure start();
procedure pieces();
procedure chambre();
procedure cantine();
procedure marchand();
procedure vente();
procedure armoire();
procedure inventaire();
procedure achat();
procedure validationAchat();
procedure forge();

implementation
uses
  Classes, SysUtils, menu,uniteCantine,uniteChambre,uniteMarchand,uniteforge;

procedure start();
begin
  case menuPrincipal() of
       1: menuPerso();
       2:if (menuHistoire() = 1) then start();
       3: menuQuitter();
  else start()
  end;
end;

procedure pieces();
begin
  case menuJeu() of
       1: chambre();
       //2: forge();
       3: marchand();
       4: cantine();
       //5: chasser();
  else pieces()
  end;
end;

procedure chambre();
begin
  case menuChambre() of
       1: menuLit;
       2: armoire;
       3: pieces();
  else chambre()
  end;
end;

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

procedure marchand();
begin
  case menuMarchand() of
       1: achat;
       2: vente();
       3: pieces();
  else marchand()
  end;
end;

procedure achat();
begin
  case menuAchat() of
       1: validationAchat();
       2: validationAchat();
       3: validationAchat();
       4: validationAchat();
       5: validationAchat();
       6: validationAchat();
       7: validationAchat();
       8: marchand();
  else achat()
  end;
end;

procedure validationAchat();
begin
  case potion() of
       1: Oui();
       2: achat();
  else validationAchat()
  end;
end;

procedure vente();
begin
  case menuVente() of
       1: inventaire();
       //2: validationVente();
       3: marchand();
  else vente()
  end;
end;

procedure inventaire();
begin
  case menuInventaire of
       21: vente();
  else inventaire()
  end;
end;

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

