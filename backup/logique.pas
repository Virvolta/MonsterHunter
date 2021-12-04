unit logique;

{$mode objfpc}{$H+}

interface

uses
  outils;

procedure start();
procedure pieces();
procedure chambre();
procedure cantine();
procedure marchand();
procedure armoire();
procedure achat();
procedure affichageachat(index:integer);
procedure vente();
procedure forge();
procedure lit();
procedure chasse();
procedure reward(monster:monstre);

implementation

uses
  Classes, SysUtils, menu,uniteCantine,uniteChambre,uniteMarchand
  ,uniteChasse, personnage;

// cette procedure fait marcher tout le jeu
procedure start();

begin

  ParseFile('json/objets.json','objets');
  ParseFile('json/equipements.json','equipements');
  ParseFile('json/monstre.json','monstres');
  ParseFile('json/cantine.json','cantines');

  case menuPrincipal() of
      1:
       begin
          setMaxHeart(250);
          setHeart(MAX_HEART);
          setDamage(5);
          setShield(0);
          setMoney(20);
          menuPerso();
       end;
      2:
       begin
           if getPseudo = '' then
              begin
                   menuNoSave();
                   start();
              end
           else
               pieces();
       end;
      3:
       begin
           menuHistoire();
           start();
       end;
      4:
       begin
           menuQuitter();
       end
  else start();
  end;

end;

// cette procedure permet de choir dans quel pieces ont veut aller
procedure pieces();

begin

  case menuJeu() of
      7: chambre();
      2: forge();
      4: marchand();
      3: cantine();
      6: chasse();
      8: start();
  else pieces()
  end;

end;

// c'est la chambre
procedure chambre();

begin

  case menuChambre() of
      1: lit();
      2: armoire();
      3: pieces();
  else chambre()
  end;

end;

// c'est l'armoire
procedure armoire();

begin

  case menuArmoire() of
      1: chambre();
      2: armoire();
  end;

end;

// c'est la cantine
procedure cantine();

var

  select : integer;

begin

  select := menuCantine();

  if (select = NOMBRE_CANTINE_ARRAY + 2) then
      pieces()
  else if (select > 0) then
     begin

         select := tabCantines[select-1].avantage;

         case select of
             1: defenseAvantage();
             2: degatsAvantage();
             3: vieAvantage();
         end;

         cantine;

      end
  else
      cantine()
  ;

end;

// c'est le marchand
procedure marchand();

begin

  case menuMarchand() of
      1: achat;
      2: vente();
      3: pieces();
  else marchand()
  end;

end;

// permet d'acheter des objets
procedure achat();

var

  select : integer;

begin

  select := menuAchat();

  if (select = (NOMBRE_PRODUIT_ARRAY - NOMBRE_PRODUIT_NOPRICE_ARRAY)) then
      marchand()
  else if (select > 0) then
      affichageachat(select + NOMBRE_PRODUIT_NOPRICE_ARRAY)
  else
      achat()
  ;

end;

// confirmer l'achat
procedure affichageachat(index:integer);

begin

  case menuAffichageAchat(index) of
      1:
      begin
          menuValidationAchat(index);
          achat();
      end;
      2: achat();
  else affichageachat(index);
  end;

end;

// vendre des objets
procedure vente();

begin

  case menuVente() of
       1: marchand();
       2: vente();
  end;

end;

// c'est la chasse
procedure chasse();

begin

  case menuChasser() of
       1 : combat(tabmonstre[0]);
       2 : combat(tabmonstre[1]);
       3 : combat(tabmonstre[2]);
       4 : pieces;
  end;

end;

// c'est la forge
procedure forge();

begin

  case menuForge() of
      1: pieces();
      2: forge();
  else forge();
  end;

end;

// c'est les loot des monstres
procedure reward(monster:monstre);

begin

  case menuReward(monster) of
    1 : chasse();
    2 : pieces();
  else reward(monster);
  end;

end;

// c'est le lit
procedure lit();

begin
  if (menuLit() = 1) then
     chambre()
  else lit();
end;

end.

