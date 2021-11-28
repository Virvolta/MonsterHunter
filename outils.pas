unit outils;

{$mode objfpc}{$H+}

interface

uses
  fpjson, jsonparser;

type
  item=record
    id:Integer;
    nom:String;
    prixAchat:Integer;
    prixVente:Integer;
  end;
  equipment=record
    id:Integer;
    nom:String;
    stat:Integer;
  end;

var

  tabItems : array [0..5] of item;
  tabEquipments : array [0..17] of equipment;

procedure displayData(data : TJSONData; ObjName : String);
procedure DoParse(Parseur : TJSONParser ; ObjName : String);
procedure ParseFile(FileName, ObjName : String);

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

procedure displayData(data : TJSONData ; ObjName : String);
 var
   obj : TJSONObject;
   tab : TJSONArray;
   i : byte;

begin
  obj :=TJSONObject(data);
  {writeln('Les caracteristiques du langage : '+obj.Strings['langage']);
  writeln('Date de creation : ',lang.Integers['annee_creation']);}
  writeln('------------- Les objets disponibles ---------------- ');
  if ObjName='objets' then
  begin
     tab:=obj.Arrays[ObjName];
     for i:=0 to tab.Count-1 do
     begin
       obj:= tab.Objects[i];
       tabItems[i].id:=StrToInt(obj.Strings['id']);
       tabItems[i].nom:=obj.Strings['nom'];
       tabItems[i].prixAchat:=StrToInt(obj.Strings['prixAchat']);
       tabItems[i].prixVente:=StrToInt(obj.Strings['prixVente']);
     end;

     for i:=0 to Length(tabItems) do
     begin
       write('id : ',tabItems[i].id);
       write(' / ');
       write('nom : ',tabItems[i].nom);
       write(' / ');
       write('prixAchat : ',tabItems[i].prixAchat);
       write(' / ');
       writeln('prixVente : ',tabItems[i].prixAchat);
     end;
  end
  else if ObjName='equipements' then
  begin
     tab:=obj.Arrays['equipements'];
     for i:=0 to tab.Count-1 do
     begin
       obj:= tab.Objects[i];
       tabEquipments[i].id:=StrToInt(obj.Strings['id']);
       tabEquipments[i].nom:=obj.Strings['nom'];
       tabEquipments[i].stat:=StrToInt(obj.Strings['stat']);
     end;

     for i:=0 to Length(tabEquipments) do
     begin
       write('id : ',tabEquipments[i].id);
       write(' / ');
       write('nom : ',tabEquipments[i].nom);
       write(' / ');
       writeln('stat : ',tabEquipments[i].stat);
     end;
  end
  else
      writeln('Aucun objet de ce type dans le fichier JSON');
  writeln('---------------------------------------');
end;

Procedure DoParse(Parseur : TJSONParser ; ObjName : String);
Var
  js : TJSONData;
begin
  js:=parseur.Parse;
  displayData(js,ObjName);
end;

Procedure ParseFile (FileName, ObjName : String);
Var
  flux : TFileStream;
  Parseur : TJSONParser;
begin
  If FileExists(FileName) then
  begin
    flux:=TFileStream.create(FileName, fmopenRead);
      try
        parseur:=TJSONParser.create(flux);
        try
          DoParse(parseur, ObjName);
        finally
          FreeAndNil(parseur);
        end;
      finally
        flux.Destroy;
      end;
  end
  else
      writeln('Le fichier JSON : ', FileName,' n''existe pas');
end;

end.

