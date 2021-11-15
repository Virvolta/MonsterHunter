unit Unit2;

{$mode objfpc}{$H+}

interface

function menu() : Integer;

procedure start();


implementation
uses
  Classes, SysUtils, Unit1;

var
   pos : coordonnees;
   result : Integer;

function menu() : Integer;
begin
  dessinerCadreXY(28,7,90,20,simple,255,0);
  pos.x := 46;
  pos.y := 8;
  ecrireEnPosition(pos, 'Monster Hunter : New World');
  pos.x := 35;
  pos.y := pos.y + 3;
  ecrireEnPosition(pos, 'Voulez-vous jouer a notre jeu :');
  pos.x := 40;
  pos.y := pos.y +2;
  ecrireEnPosition(pos, '0) Nouvelle partie');
  pos.x := 40;
  pos.y := pos.y +1;
  ecrireEnPosition(pos, '1) Quitter');
  pos.x := 50;
  pos.y := 19;
  ecrireEnPosition(pos, 'Choix : ');
  readln(result);
  menu := result;
end;

procedure start();
begin
  case menu() of
       1: writeln('Nouvelle partie');
       2: writeln('Histoire du jeux');
       3: writeln('Quitter');
  else menu()
  end;
end;

end.

