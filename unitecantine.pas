unit uniteCantine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,personnage,outils,controle;

procedure defenseAvantage();
procedure degatsAvantage();
procedure vieAvantage();
procedure vitesseAvantage();
function menuCantine():Integer;
function avantageinttostring(c : integer) : string;

implementation

var
   pos : coordonnees;


// cette fonction montre ce que le joueur peut acheter et lui demande de choisir ce qu'il veut
function menuCantine():Integer;
var
   ch: char;
   i: integer;
   select: integer;
   cant : cantineobj;

begin
  effacerEcran();
  couleurs(15, 0);
  ascii('cantine', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  pos.x := 74;
  pos.y := 3;
  ecrireEnPosition(pos, concat('Que voulez-vous manger ', getpseudo));
  select := 1;
  pos.x := 58;
  pos.y := 6;
  for i := Low(tabCantines) to High(tabCantines) do
      begin
        cant := tabCantines[i];
        if (select = i + 1) then
            couleurs(0, 15)
        else
            couleurs(15, 0)
        ;
        ecrireEnPosition(pos, concat(InttoStr(i + 1) , ' BOOST ', avantageinttostring(cant.avantage) , ' : ', cant.nom, ' ', InttoStr(cant.prixAchat), ' E'));
        pos.y := 7 + i;
      end;
  couleurs(15, 0);
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select > High(tabCantines) + 2) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := High(tabCantines) + 2;
      end;
    end;
    pos.x := 58;
    pos.y := 6;
    for i := Low(tabCantines) to High(tabCantines) do
      begin
        cant := tabCantines[i];
        if (select = i + 1) then
            couleurs(0, 15)
        else
            couleurs(15, 0)
        ;
        ecrireEnPosition(pos, concat(InttoStr(i + 1) , ' BOOST ', avantageinttostring(cant.avantage) , ' : ', cant.nom, ' ', InttoStr(cant.prixAchat), ' E'));
        pos.y := 7 + i;
      end;
    if (select = High(tabCantines) + 2) then
       begin
          couleurs(0, 15);
          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')
       end
    else
        begin
          couleurs(15, 0);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')
        end
    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;
  menuCantine := select;
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure defenseAvantage();
var
   ch : char;
begin
  effacerEcran();
  if hasMoney(15) then
  begin
    couleurs(15, 0);
    ascii('cantine_avantage',0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 47;
    pos.y := 12;
    ecrireEnPosition(pos, 'Vous avez un boost de 5 en defense');
    delMoney(15);
    addShield(5);
  end
  else
  begin
    couleurs(15, 0);
    ascii('achat_affichage', 0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 30;
    pos.y := 12;
    ecrireEnPosition(pos, 'vous n''avez pas assez d''argent pour un boost de 5 en defense');
    pos.x := 50;
    pos.y := 13;
    ecrireEnPosition(pos, concat('vous n''avez que ', InttoStr(getMoney()), ' E'));
  end;
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure degatsAvantage();
var
   ch : char;
begin
  effacerEcran();
  if hasMoney(15) then
    begin
        couleurs(15, 0);
    ascii('cantine_avantage',0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 47;
    pos.y := 12;
    ecrireEnPosition(pos, 'Vous avez un boost de 3 en degats');
    delMoney(15);
    addDamage(3);
  end
  else
  begin
    couleurs(15, 0);
    ascii('achat_affichage', 0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 30;
    pos.y := 12;
    ecrireEnPosition(pos, 'vous n''avez pas assez d''argent pour un boost de 3 en degats');
    pos.x := 50;
    pos.y := 13;
    ecrireEnPosition(pos, concat('vous n''avez que ', InttoStr(getMoney()), ' E'));
  end;
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure vieAvantage();
var
   ch : char;
begin
  effacerEcran();
  if hasMoney(15) then
    begin
    couleurs(15, 0);
    ascii('cantine_avantage',0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 47;
    pos.y := 12;
    ecrireEnPosition(pos, 'Vous avez un boost de 3 en vie');
    delMoney(15);
    setMaxHeart(getMaxHeart() + 3);
  end
  else
  begin
    couleurs(15, 0);
    ascii('achat_affichage', 0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 30;
    pos.y := 12;
    ecrireEnPosition(pos, 'vous n''avez pas assez d''argent pour un boost de 3 en vie');
    pos.x := 50;
    pos.y := 13;
    ecrireEnPosition(pos, concat('vous n''avez que ', InttoStr(getMoney()), ' E'));
  end;
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;
end;

// cette procedure donne un boost au joueur et lui retire des sous si il les a
procedure vitesseAvantage();
var
   ch : char;
begin
  effacerEcran();
  if hasMoney(15) then
    begin
        couleurs(15, 0);
    ascii('cantine_avantage',0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 47;
    pos.y := 12;
    ecrireEnPosition(pos, 'Vous avez un boost de 1,5 en vitesse');
    delMoney(15);
    addDamage(3);
  end
  else
  begin
    couleurs(15, 0);
    ascii('achat_affichage', 0, 0);
    pos.x := 1;
    pos.y := 28;
    dessinerCadreXY(2,11,118,14,double,255,0);
    ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
    pos.x := 30;
    pos.y := 12;
    ecrireEnPosition(pos, 'vous n''avez pas assez d''argent pour un boost de 1,5 en vitesse');
    pos.x := 50;
    pos.y := 13;
    ecrireEnPosition(pos, concat('vous n''avez que ', InttoStr(getMoney()), ' E'));
  end;
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;
end;

function avantageinttostring(c : integer) : string;
var
   avantage : string;
begin
  case c of
       1: avantage := 'defense';
       2: avantage := 'degat';
       3: avantage := 'vie';
       4: avantage := 'vitesse';
  else avantage := 'unknow';
  end;
  avantageinttostring := avantage;
end;

end.

