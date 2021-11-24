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

implementation
uses
  Classes, SysUtils, menu,uniteCantine,uniteChambre,uniteMarchand;

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
       1: menuAchat;
       2: vente();
       3: pieces();
  else marchand()
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

end.

