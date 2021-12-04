unit outils;

{$mode objfpc}{$H+}

interface

uses
  fpjson, jsonparser;

type // type qui nous permet d'enregistrer les caractéristique des produits, des équipements, des monstres, des items et de la cantines
  produit=record
    id:Integer;
    nom:String;
    prixAchat:Integer;
    prixVente:Integer;
  end;

  equipment=record
    id:Integer;
    nom:String;
    stat:Integer;
    slot:Integer;
  end;

  monstre=record
    niveau:Integer;
    nom:String;
    hp:Integer;
    degatmin:Integer;
    degatmax:Integer;
    defensemin:Integer;
    defensemax:Integer;
  end;

  item=record
    id: Integer;
    count:Integer;
    unique:Boolean;
  end;

  cantineobj=record
    nom:String;
    prixAchat:Integer;
    avantage:Integer;
  end;

const

  NOMBRE_PRODUIT_NOPRICE_ARRAY = 3;
  NOMBRE_PRODUIT_ARRAY = 11;
  NOMBRE_EQUIPEMENT_ARRAY = 18;
  NOMBRE_MONSTRE_ARRAY = 2;
  NOMBRE_CANTINE_ARRAY = 2;

var

  tabProduits : array [0..NOMBRE_PRODUIT_ARRAY] of produit; // stockage des produits
  tabEquipments : array [0..NOMBRE_EQUIPEMENT_ARRAY] of equipment; // stockage des equipements

  tabCantines : array [0..NOMBRE_CANTINE_ARRAY] of cantineobj; // stockage des objets disponible dans la cantine

  tabMonstre : array [0..NOMBRE_MONSTRE_ARRAY] of monstre; // stockage des informations des monstres

  tabIdProduits : array [0..NOMBRE_PRODUIT_ARRAY] of integer;  // stockage des produits
  tabIdEquipments : array [0..NOMBRE_EQUIPEMENT_ARRAY] of integer; // stockage des equipements

procedure importObjData(data : TJSONData; ObjName : String);
procedure importMonsterData(data : TJSONData; ObjName : String);
procedure DoParse(Parseur : TJSONParser ; ObjName : String);
procedure ParseFile(FileName, ObjName : String);

procedure ascii(nom : string; x, y : integer);
procedure animationdeplacement(x, y, x2, y2 : integer);

implementation
uses
  Classes, SysUtils, GestionEcran;

// cette procedure nous permet d'utiliser les fichers ascii
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

// cette procedure permet de faire ce deplacer un petit carré bleu pour simuler le deplacement du joueur
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

// cette procedure nous permet d'utiliser des fichier json
procedure importObjData(data : TJSONData ; ObjName : String);
 var
   obj : TJSONObject;
   tab : TJSONArray;
   i : byte;

begin
  obj :=TJSONObject(data);
  {writeln('Les caracteristiques du langage : '+obj.Strings['langage']);
  writeln('Date de creation : ',lang.Integers['annee_creation']);}
  //writeln('------------- Les objets disponibles ---------------- ');
  if ObjName='objets' then
  begin
     tab:=obj.Arrays[ObjName];
     for i:=0 to tab.Count-1 do
     begin
       obj:= tab.Objects[i];
       tabProduits[i].id:=StrToInt(obj.Strings['id']);
       tabProduits[i].nom:=obj.Strings['nom'];
       tabProduits[i].prixAchat:=StrToInt(obj.Strings['prixAchat']);
       tabProduits[i].prixVente:=StrToInt(obj.Strings['prixVente']);
       tabIdProduits[StrToInt(obj.Strings['id'])] := i;
     end;

     {for i:=0 to tab.Count-1 do
     begin
       write('id : ',tabProduits[i].id);
       write(' / ');
       write('nom : ',tabProduits[i].nom);
       write(' / ');
       write('prixAchat : ',tabProduits[i].prixAchat);
       write(' / ');
       writeln('prixVente : ',tabProduits[i].prixVente);
     end;}
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
       tabEquipments[i].slot:=StrToInt(obj.Strings['slot']);
       tabIdEquipments[StrToInt(obj.Strings['id'])] := i;
     end;

     {for i:=0 to tab.Count-1 do
     begin
       write('id : ',tabEquipments[i].id);
       write(' / ');
       write('nom : ',tabEquipments[i].nom);
       write(' / ');
       write('stat : ',tabEquipments[i].stat);
       write(' / ');
       writeln('slot : ',tabEquipments[i].slot);
     end;}
  end
  else if ObjName='cantines' then
  begin
     tab:=obj.Arrays['cantines'];
     for i:=0 to tab.Count-1 do
     begin
       obj:= tab.Objects[i];
       tabCantines[i].nom:=obj.Strings['nom'];
       tabCantines[i].prixAchat:=StrToInt(obj.Strings['prixAchat']);
       tabCantines[i].avantage:=StrToInt(obj.Strings['avantage']);
     end;

     {for i:=0 to tab.Count-1 do
     begin
       write('id : ',tabEquipments[i].id);
       write(' / ');
       write('nom : ',tabEquipments[i].nom);
       write(' / ');
       write('stat : ',tabEquipments[i].stat);
       write(' / ');
       writeln('slot : ',tabEquipments[i].slot);
     end;}
  end
  else
      writeln('Aucun objet de ce type dans le fichier JSON');
  //writeln('---------------------------------------');
end;

// cette procedure nous permet d'importer les montres depuis un fichier json
procedure importMonsterData(data : TJSONData; ObjName : String);

var

   obj : TJSONObject;
   tab : TJSONArray;
   i : byte;

begin
  obj :=TJSONObject(data);
  {writeln('Les caracteristiques du langage : '+obj.Strings['langage']);
  writeln('Date de creation : ',lang.Integers['annee_creation']);}
  //writeln('------------- Les monstres disponibles ---------------- ');
  tab:=obj.Arrays[ObjName];
  for i:=0 to tab.Count-1 do
  begin
    obj:= tab.Objects[i];
    tabMonstre[i].niveau:=StrToInt(obj.Strings['niveau']);
    tabMonstre[i].nom:=obj.Strings['nom'];
    tabMonstre[i].hp:=StrToInt(obj.Strings['HP']);
    tabMonstre[i].degatmin:=StrToInt(obj.Strings['degatmin']);
    tabMonstre[i].degatmax:=StrToInt(obj.Strings['degatmax']);
    tabMonstre[i].defensemin:=StrToInt(obj.Strings['defensemin']);
    tabMonstre[i].defensemax:=StrToInt(obj.Strings['defensemax']);
  end;

  {for i:=0 to tab.Count-1 do
  begin
    write('niveau : ',tabMonstre[i].niveau);
    write(' / ');
    write('nom : ',tabMonstre[i].nom);
    write(' / ');
    write('HP : ',tabMonstre[i].hp);
    write(' / ');
    write('degatmin : ',tabMonstre[i].degatmin);
    write(' / ');
    write('degatmax : ',tabMonstre[i].degatmax);
    write(' / ');
    write('defensemin : ',tabMonstre[i].defensemin);
    write(' / ');
    writeln('defensemax : ',tabMonstre[i].defensemax);
  end;
  //writeln('---------------------------------------');}
end;

// cette procedure affiche les données json
Procedure DoParse(Parseur : TJSONParser ; ObjName : String);
Var
  js : TJSONData;
begin
  js:=parseur.Parse;
  if (ObjName='objets') or (ObjName='equipements') or (ObjName='cantines') then
     importObjData(js,ObjName)
  else
      importMonsterData(js,ObjName);
end;

// cette procedure créé des parties dans les fichiers json
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

