unit logique;

{$mode objfpc}{$H+}

interface

procedure start();
procedure pieces();
procedure chambre();
procedure cantine();

implementation
uses
  Classes, SysUtils, menu;

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
       2: forge();
       3: marchand();
       4: cantine()
  else pieces()
  end;
end;
procedure chambre();
begin
  case menuChambre() of
       1: menuLit;
       2: menuArmoire;
       3: pieces();
  else chambre()
  end;
end;

procedure cantine();
begin
  case menuCantine() of
       //1: defense;
       //2: degats;
       //3: vie;
       //4: vitesse;
       5: pieces();
  else cantine();
  end;
end;
end.

