unit logique;

{$mode objfpc}{$H+}

interface

procedure start();
procedure pieces();

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
       1: menuChambre();
       2: forge();
       3: marchand();
       4: cantine()
  else pieces()
  end;
end;

end.

