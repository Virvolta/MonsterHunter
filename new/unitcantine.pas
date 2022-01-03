//Unit en charge de la cantine
unit unitCantine;
{$codepage utf8}
{$mode objfpc}{$H+}

interface
//----- FONCTIONS ET PROCEDURES -----
uses
  unitLieu;

const
  nbRecette = 5000;
  Fichier='Recettes.txt';

type
  recette = record
    nom : String;
    idBonus : Integer;
  end;

  TcatalogueRecette = array[1..nbRecette] of recette;

var
  CatalogueRecette : TcatalogueRecette;


//Fonction exécutée à l'arrivée dans la cantine
//Renvoie le prochain lieu à visiter
function cantineHUB() : typeLieu;
procedure initialisationCantine();












implementation
uses
  sysutils,unitPersonnage,unitIHM,GestionEcran;

//Initialisation cantine
procedure initialisationCantine();
var
 File1: TextFile;
 Str, nomBonus: String;
 indexBonus: Integer;
 Separateur, ParentheseFin : Integer;
 i: Integer;
 pos:Integer;

begin
  pos:=0;
  if not FileExists(Fichier) then exit;
  AssignFile(File1, Fichier);
  Reset(File1);
  i:=0;
  while not Eof(File1) do
    begin
      Readln(File1, Str);

      Separateur := AnsiPos('/',Str);
      ParentheseFin := AnsiPos(')',Str);

      nomBonus:=Str[Separateur+2..ParentheseFin-1];
      case nomBonus of
           'Force':indexBonus:=1;
           'Regeneration':indexBonus:=2;
           'Critique':indexBonus:=3;
      end;

      i:=i+1;

      CatalogueRecette[i].nom:= Str[1..Separateur-1];
      CatalogueRecette[i].idBonus:=indexBonus;
    end;
  CloseFile(File1);
end;

//Affiche les plats et les bonus
procedure affiche(t:TcatalogueRecette;pos1,pos2:Integer);
var
  i : integer;
  x,y : integer;
begin
  y:=9;
     for i:=pos1 to pos2 do
         begin
           x:=21;
           deplacerCurseurXY(x,y);
           write(t[i].nom);
           x:=116;
           deplacerCurseurXY(x,y);
           write(bonusToString(bonus(t[i].idBonus)));
           y:=y+2;
         end;
     writeln;
end;

//Tri la liste de A..Z
procedure triInsertionNom(var t:TcatalogueRecette);
var
  i,j,k : integer ; //Entier pour la boucle
  temp : recette ; //Variable temporaire qui stocke une recette
begin
     for i := 1 to length(t)-1 do
         begin
              if (t[i+1].nom<t[i].nom) then
                begin
                  j:=1;
                  while (t[j].nom < t[i+1].nom) do
                        begin
                          j:=j+1;
                        end;
                  temp:= t[i+1];
                  //Decale Ã  partir de la fin
                  for k := i+1 downto j+1 do
                      begin
                        t[k]:= t[k-1];
                      end;
                  t[j] := temp;
                end;
         end;
end;

//Tri la liste par bonus de A..Z
procedure triInsertionBonus(var t:TcatalogueRecette);
var
  i,j,k : integer ; //Entier pour la boucle
  temp : recette ; //Variable temporaire qui stocke une recette
begin
     for i := 1 to length(t)-1 do
         begin
              if (t[i+1].idBonus<t[i].idBonus) then
                begin
                  j:=1;
                  while (t[j].idBonus < t[i+1].idBonus) do
                        begin
                          j:=j+1;
                        end;
                  temp:= t[i+1];
                  //Decale Ã  partir de la fin
                  for k := i+1 downto j+1 do
                      begin
                        t[k]:= t[k-1];
                      end;
                  t[j] := temp;
                end;
         end;
end;

//Mange le plat et applique le bonus
procedure manger(nbPlat : integer);
begin
     //Fixe le buff
     setBuff(bonus(nbPlat));
end;
       
//Fonction exécutée pour afficher l'écran d'affichage des recettes
//Renvoie le prochain lieu à visiter
function choixRecette() : typeLieu;
var choix : string;
  choixNumber : integer;
  page : Integer;
  choixpage : integer;
begin
  choix := '';
  page:=1;
  while (choix <> '0') do
  begin
    afficherInterfacePrincipale();
    afficherLieu('Cantine de la ville de Brightwood');

    deplacerCurseurXY(63,5);write('Le cuisinier vous proposent :');
    couleurTexte(Cyan);
    deplacerCurseurXY(48,7);write('Plat');
    deplacerCurseurXY(119,7);write('Bonus');
    couleurTexte(White);
    affiche(CatalogueRecette,page*10-9,page*10);

    deplacerCurseurZoneAction(1);write('Que souhaitez-vous faire ?');
    deplacerCurseurZoneAction(3);write('     ?/ Commander un plat (entrer son numéro dans la page)');

    deplacerCurseurXY(78,31);write('Page ',page,' / 500');

    deplacerCurseurXY(75,33);write('-/ Page précédente');
    deplacerCurseurXY(76,36);write('+/ Page suivante');
    deplacerCurseurXY(109,33);write('!/ Pour saisir une page');
    deplacerCurseurXY(109,35);write('a/ Tri A..Z');
    deplacerCurseurXY(109,36);write('b/ Tri par bonus');

    deplacerCurseurZoneAction(6);write('     0/ Retourner sur la place principale');

    deplacerCurseurZoneResponse();
    readln(choix);

    //Si l'utilisateur saisit 0 => sortir
    if(choix = '0') then choixRecette := ville
    //Si l'utilisateur saisit un nombre, convertir choix (string) en choixNumber (integer)
    else if (choix= '-') and (page>1) then page := page - 1
    else if (choix= '+') and (page<500) then page := page + 1
    else if (choix= '!') then
      begin
        repeat
          dessinerCadreXY(45,13,105,17,simple,White,Black);
          deplacerCurseurXY(61,14);write('Indiquez le numéro de la page');
          deplacerCurseurXY(75,16);
          readln(choix);
          if(TryStrToInt(choix,choixpage)) then
             page:=choixpage;
        until (choixpage > 0) and (choixpage <= 500);
        page:=choixpage;
      end
    else if (choix= 'a') then
      triInsertionNom(CatalogueRecette)
    else if (choix= 'b') then
      triInsertionBonus(CatalogueRecette)
    else if(TryStrToInt(choix,choixNumber)) then
    begin
         //Si la recette existe, la manger
         if(choixNumber > 0) and (choixNumber < 11) and (page=1) then
         manger(CatalogueRecette[choixNumber].idBonus)
         else if (choixNumber > 0) and (choixNumber < 11) and (page>1) and (page<500) then
         manger(CatalogueRecette[choixNumber+10*page-10].idBonus)
         else if (choixNumber > 0) and (choixNumber < 11) and (page=500) then
         manger(CatalogueRecette[10*page-(10-choixNumber)].idBonus);
    end;
  end;

end;

//Fonction exécutée à l'arrivée dans la cantine
//Renvoie le prochain lieu à visiter
function cantineHUB() : typeLieu;
var choix : string;
begin
  choix := '';
  while (choix <> '0') and (choix <> '1') do
  begin
    afficherInterfacePrincipale();
    afficherLieu('Cantine de la ville de Brightwood');

    deplacerCurseurXY(30,7);write('Alors que vous approchez de la cantine, l''air s''emplit d''un épais fumet. Viandes, poissons,');
    deplacerCurseurXY(30,8);write('fruits et légumes dont certains vous sont inconnus sont exposés sur les nombreuses tables');
    deplacerCurseurXY(30,9);write('qui entourent une cuisine de fortune où des palicos s''affairent à préparer des mets aussi');
    deplacerCurseurXY(30,10);write('généreux qu''appétissants.');

    deplacerCurseurXY(30,12);write('Vous apercevez de nombreux chasseurs assis aux différentes tables de la cantine. Les rires');
    deplacerCurseurXY(30,13);write('et les chants résonnent créant en ce lieu, une ambiance chaleureuse et rassurante.');

    deplacerCurseurXY(30,15);write('Alors que vous vous asseyez à une table, un palico vous rejoint posant devant vous une cho');
    deplacerCurseurXY(30,16);write('pe et attendant votre commande.');

    couleurTexte(White);
    deplacerCurseurZoneAction(1);write('Que souhaitez-vous faire ?');
    deplacerCurseurZoneAction(3);write('     1/ Commander un plat');

    deplacerCurseurZoneAction(6);write('     0/ Retourner sur la place principale');

    deplacerCurseurZoneResponse();
    readln(choix);
  end;

  case choix of
       '0' : cantineHUB := ville;
       '1' : cantineHUB := choixRecette();
  end;

end;
end.

