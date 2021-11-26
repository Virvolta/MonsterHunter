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
   hr, min, sec, ms: Word;
   contsec: string;
   ch : char;
   anime : boolean;
   time2 : Integer;
   move : Integer;
   pos: coordonnees;
begin
  time2 := 0;
  anime := false;
  contsec := '-1';

  if (x = x2) then
      move := 1
  else
      move := 2;
  repeat
    DecodeTime(Time,hr, min, sec, ms);
    if (format('%d',[sec]) <> contsec) then
    begin
            couleurs(15, 0);
            pos.x := x + ((time2) * 8);
            pos.y := y;
            ecrireEnPosition(pos, '       ');
            pos.y := pos.y + 1;
            ecrireEnPosition(pos, '       ');
            pos.y := pos.y + 1;
            ecrireEnPosition(pos, '       ');
            time2 := time2+1;
            contsec :=format('%d',[sec]);
            if (anime = true) then
            begin
                 if (move = 1) then
                    ascii('deplacement', x, y + (time2 * 8))
                 else
                    ascii('deplacement', x + (time2 * 8), y);
                 anime := false;
            end
            else
            begin
                 if (move = 1) then
                    ascii('deplacement2', x, y + (time2 * 8))
                 else
                    ascii('deplacement2', x + (time2 * 8), y);
                 anime := true;
            end;
    end;

  until time2 = 4;
end;

end.

