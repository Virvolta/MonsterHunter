unit logique;

{$mode objfpc}{$H+}

interface

procedure start();
procedure pieces();
procedure chambre();
procedure cantine();
procedure marchand();
procedure vente(index:integer);
procedure armoire();
procedure inventaire();
procedure achat();
procedure validationAchat(index:integer);
procedure forge();
procedure valideVente(index:integer);

implementation
uses
  Classes, SysUtils, menu,uniteCantine,uniteChambre,uniteMarchand
  ,uniteChasse, outils, personnage;

// cette procedure fait marcher tout le jeu
procedure start();
begin
  ParseFile('json/objets.json','objets');
  ParseFile('json/equipements.json','equipements');
  ParseFile('json/monstre.json','monstres');
  case menuPrincipal() of
       1: menuPerso();
       2:
         begin
           menuHistoire();
           start();
         end;
       3: menuQuitter();
  else start()
  end;
end;

// cette procedure permet de choir dans quel pieces ont veut aller
procedure pieces();
begin
  setMaxHeart(200);
  setHeart(200);
  setDamage(5);
  setShield(0);
  setMoney(20);
  case menuJeu() of
       7: chambre();
       2: forge();
       4: marchand();
       3: cantine();
       6: chasser();
  else pieces()
  end;
end;

// c'est la chambre
procedure chambre();
begin
  case menuChambre() of
       1: menuLit;
       2: armoire;
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
begin
  case menuCantine() of
       1: defense;
       2: degats;
       3: vie;
       4: vitesse;
       5: pieces();
  else cantine();
  end;
end;

// c'est le marchand
procedure marchand();
begin
  case menuMarchand() of
       1: achat;
       2: vente(0);
       3: pieces();
  else marchand()
  end;
end;

// permet d'acheter des objets
procedure achat();
begin
  case menuAchat() of
       1: validationAchat(4);
       2: validationAchat(5);
       3: validationAchat(6);
       4: validationAchat(7);
       5: validationAchat(8);
       6: validationAchat(9);
       7: validationAchat(10);
       8: marchand();
  else achat()
  end;
end;

// confirmer l'achat
procedure validationAchat(index:integer);
begin
  case potion(index) of
       1: Oui(index);
       2: achat();
  else validationAchat(index)
  end;
end;

// vendre des objets
procedure vente(index:integer);
begin
  case menuVente() of
       1: marchand();
       2: inventaire();
       3: valideVente(index);
  else vente(index)
  end;
end;

// confirmer la vente
procedure valideVente(index:integer);
begin
  case validationVente(index) of
       4: UI(index);
       5: vente(index);
  else valideVente(index)
  end;
end;

// c'est l'inventaire
procedure inventaire();
begin
  case menuInventaire of
       21: vente(0);
  else inventaire()
  end;
end;

// c'est la forge
procedure forge();

begin

  menuForge();


end;

end.

