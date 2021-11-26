unit outils;

{$mode objfpc}{$H+}

interface

procedure ascii(nom : string; x, y : integer);
procedure animationdeplacement(x, y, x2, y2 : integer);

implementation
uses
  Classes, SysUtils, ihm;

procedure ascii(nom : string; x, y : integer);
    var
       fichier : textFile;
       ligne : string;
       compteurLigne : integer;
       i : Integer;
    begin
      assignFile(fichier, concat('ascii/', nom, '.ascii'));
      reset(fichier);
      compteurLigne := 0;
      repeat
        readln(fichier,ligne);
        deplacerCurseurXY(x,y+compteurLigne);
        for i := 1 to length(ligne) do
            case ligne[i] of
                  '1' : write(char(176));
                  '2' : write(char(177));
                  '3' : write(char(178));
                  '4' : write(char(219));
            else write(ligne[i])
            end;
        compteurLigne := compteurLigne +1
      until(EOF(fichier));
      closeFile(fichier);
    end;

procedure animationdeplacement(x, y, x2, y2 : integer);
var
   contsec: string;
   ch : char;
   anime : boolean;
   move : Integer;
   pos: coordonnees;
begin
  x2 := x + (x2 *2);
  y2 := y + (y2 *2);
  anime := true;
  contsec := '-1';
  repeat
    attendre(50);

    couleurs(15, 0);
    deplacerCurseurXY(x, y);
    write(char(176),char(176));
    if ((x = x2) and (y = y2)) then
       begin
         anime := false;
       end
    else if (x = x2) then
       begin
            if (y > y2) then
               y := y - 2
            else
                y := y + 2;
       end
    else
        begin
             if (x > x2) then
                x := x - 2
             else
                 x := x + 2;
       end;
    ;
    couleurs(3, 0);
    deplacerCurseurXY(x, y);
    write(char(219),char(219));

  until anime = false;
end;

end.

