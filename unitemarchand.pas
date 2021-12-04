unit uniteMarchand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,uniteObjets,outils,personnage, controle,uniteforge;

function menuMarchand(): Integer;

function menuVente():Integer;
procedure menuAffichageVente(id,count : integer);
procedure menuValidationVente(id,count : integer);

function menuAchat():Integer;
function menuAffichageAchat(index:integer) : Integer;
procedure menuValidationAchat(index:integer);

implementation

var
   pos : coordonnees;

// cette fonction affiche le menu marchand et nous permet de choisir entre vendre et acheter
function menuMarchand(): Integer;
var
   select : integer;
   ch : char;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('marchand', 0, 0);
  couleurs(0, 15);
  pos.x := 23;
  pos.y := 23;
  ecrireEnPosition(pos, 'Acheter');
  couleurs(15, 0);
  pos.x := 90;
  pos.y := 23;
  ecrireEnPosition(pos, 'Vendre');
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
  deplacerCurseurXY(0, 0);
  select := 1;
  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
        select := 1;
      end;
      'M':
      begin
        select := 2;
      end;
      'P':
      begin
        if (select <> 3) then
           select := 3;
      end;
      'H':
      begin
        if (select = 3) then
           select := 1;
      end;
    end;
    case select of
      1:
      begin
           couleurs(0, 15);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Acheter');
           couleurs(15, 0);
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Vendre');
           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           deplacerCurseurXY(0, 0);
      end;
      2:
      begin
           couleurs(0, 15);
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Vendre');
           couleurs(15, 0);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Acheter');

           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           deplacerCurseurXY(0, 0);
      end;
      3:
      begin
           couleurs(0, 15);
           pos.x := 58;
           pos.y := 27;
           ecrireEnPosition(pos, 'Menu');
           couleurs(15, 0);
           pos.x := 23;
           pos.y := 23;
           ecrireEnPosition(pos, 'Acheter');
           pos.x := 90;
           pos.y := 23;
           ecrireEnPosition(pos, 'Vendre');
           deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuMarchand := select;
end;

// cette fonction sert a afficher le menu vente
function menuVente():Integer;
var
   ch: char;
   i: integer;
   n : integer;
   select: integer;
   inv,posinv : TypeInventaire;
   prod : produit;
   count: Integer;
   it : item;

begin
  effacerEcran();
  couleurs(15, 0);
  select := 1;
  ascii('vente', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  pos.x := 46;
  pos.y := 8;
  ecrireEnPosition(pos, concat('Que voulez-vous vendre ', getpseudo()));
  pos.y := 9;
  ecrireEnPosition(pos, concat('Vous avez ', Inttostr(getMoney()), ' d''argent'));
  pos.x := 35;
  pos.y := 12;
  count := 0;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0)) then
           begin
              if (select = count + 1) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;

              if ((tabProduits[tabIdProduits[it.id]].id = it.id) and (tabProduits[tabIdProduits[it.id]].prixVente > 0) ) then
                 begin
                     count := count + 1;
                     posinv[count] := it;
                     ecrireEnPosition(pos, concat(InttoStr(count) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count), ' : prix unite de ', InttoStr(tabProduits[tabIdProduits[it.id]].prixVente), ' E'));
                 end;
              pos.y := 12 + count;
           end;
      end;
  if (select = count + 1) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
  pos.x := 35;
  pos.y := 27;
  ecrireEnPosition(pos, 'Retour au menu marchand');
  couleurs(15, 0);
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select > count + 1) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := count + 1;
      end;
    end;
    pos.x := 35;
  pos.y := 12;
  count := 0;
  inv := getInventory();
  for i := Low(inv) to High(inv) do
      begin
        it := getItemInventory(i);
        if ((it.id > 0)) then
           begin
              if (select = count + 1) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;

              if ((tabProduits[tabIdProduits[it.id]].id = it.id) and (tabProduits[tabIdProduits[it.id]].prixVente > 0) ) then
                 begin
                     count := count + 1;
                     posinv[count] := it;
                     ecrireEnPosition(pos, concat(InttoStr(count) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count), ' : prix unite de ', InttoStr(tabProduits[tabIdProduits[it.id]].prixVente), ' E'));
                 end;
              pos.y := 12 + count;
           end;
      end;
    if (select = count + 1) then
       begin
          couleurs(0, 15);
          pos.x := 35;
          pos.y := 27;
          ecrireEnPosition(pos, 'Retour au menu marchand');
       end
    else
        begin
          couleurs(15, 0);
          pos.x := 35;
          pos.y := 27;
          ecrireEnPosition(pos, 'Retour au menu marchand');
        end
    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;
  if (select = count + 1) then
     menuVente := 1
  else
     begin
        effacerEcran();
        ascii('achat_affichage', 0, 0);
        pos.x := 1;
        pos.y := 28;
        ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
        dessinerCadreXY(2,11,118,14,double,255,0);
        pos.x := 47;
        pos.y := 12;
        ecrireEnPosition(pos, 'Combien voulez vous vendre : ');
        readln(n);
         it := posinv[select];
         if (n > it.count) then
             begin
                 pos.x := 1;
                 pos.y := 28;
                 ecrireEnPosition(pos, 'appuyer sur entrer pour revenir   ');
                 pos.x := 30;
                 pos.y := 12;
                 ecrireEnPosition(pos, concat('vous avez mis trop de nombre item                 '));
                 deplacerCurseurXY(0, 0);
                 repeat
                     ch := ReadKey;
                 until ch = #13;
                 menuVente := 2;
             end
          else
             begin
                 menuVente := 3;
                 menuAffichageVente(it.id, n);
             end;
    end;
end;

procedure menuAffichageVente(id,count : integer);
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  ascii('achat_affichage', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
  dessinerCadreXY(2,11,118,14,double,255,0);
  pos.x := 47;
  pos.y := 12;
  ecrireEnPosition(pos, 'Voulez vous vraiment vendre');
  pos.x := 47;
  pos.y := 13;
  ecrireEnPosition(pos, concat('un ', tabProduits[tabIdProduits[id]].nom, ' x', InttoStr(count)));
  dessinerCadreXY(29,24,90,26,double,255,0);
  couleurs(0, 15);
  pos.x := 31;
  pos.y := 25;
  ecrireEnPosition(pos, 'Oui');
  couleurs(15, 0);
  pos.x := 86;
  pos.y := 25;
  ecrireEnPosition(pos, 'Non');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
        select := select + 1;
        if (select >= 2) then
          select := 1;
      end;
      'M':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 31;
        pos.y := 25;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 86;
        pos.y := 25;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 86;
        pos.y := 25;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 31;
        pos.y := 25;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  if (select = 1) then
     menuValidationVente(id, count)
  else
     vente();
end;

procedure menuValidationVente(id,count : integer);
var
   e : string;
   ch : char;
   prix : integer;
begin
  effacerEcran();
  ascii('achat_affichage', 0, 0);
  prix := tabProduits[tabIdProduits[id]].prixVente * count;
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
  dessinerCadreXY(2,11,118,14,double,255,0);
  pos.x := 47;
  pos.y := 12;
  ecrireEnPosition(pos, concat('votre ', tabProduits[tabIdProduits[id]].nom, ' x', InttoStr(count), ' a ete vendu'));
  pos.x := 47;
  pos.y := 13;
  ecrireEnPosition(pos, concat('vous avez gagnez ', InttoStr(prix), ' E'));
  removeItemInventory(id,count);
  addMoney(prix);
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
  until ch = #13;
  vente();
end;

// cette fonction liste tout les objets que le joueur peux acheter
function menuAchat():Integer;
var
   ch: char;
   i: integer;
   select: integer;
   prod : produit;
   count : integer;
   posproduit : array[1..NOMBRE_PRODUIT_ARRAY] of Integer;

begin
  effacerEcran();
  couleurs(15, 0);
  ascii('achat', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  pos.x := 46;
  pos.y := 8;
  ecrireEnPosition(pos, concat('Que voulez-vous acheter ', getpseudo()));
  pos.y := 9;
  ecrireEnPosition(pos, concat('Vous avez ', Inttostr(getMoney()), ' d''argent'));
  pos.x := 35;
  pos.y := 12;
  count := 0;
  select := 1;
  for i := Low(tabProduits) to High(tabProduits) do
      begin
        prod := tabProduits[i];
        if (prod.prixAchat > 0) then
           begin
              count := count + 1;
              posproduit[count] := i;
              if (select = count) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              ecrireEnPosition(pos, concat(InttoStr(count) , ' ',tabProduits[i].nom, ' ', InttoStr(tabProduits[i].prixAchat), ' E'));
              pos.y := 12 + count;
           end;
      end;
  couleurs(15, 0);
  pos.x := 35;
  pos.y := 27;
  ecrireEnPosition(pos, 'Retour au menu marchand');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select > count + 1) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := count + 1;
      end;
    end;
    pos.x := 35;
    pos.y := 12;
    count := 0;
    for i := Low(tabProduits) to High(tabProduits) do
      begin
        prod := tabProduits[i];
        if (prod.prixAchat > 0) then
           begin
              count := count + 1;
              posproduit[count] := i;
              if (select = count) then
                 couleurs(0, 15)
              else
                 couleurs(15, 0)
              ;
              ecrireEnPosition(pos, concat(InttoStr(count) , ' ',tabProduits[i].nom, ' ', InttoStr(tabProduits[i].prixAchat), ' E'));
              pos.y := 12 + count;
           end;
      end;
    if (select = count + 1) then
       begin
          couleurs(0, 15);
          pos.x := 35;
          pos.y := 27;
          ecrireEnPosition(pos, 'Retour au menu marchand');
       end
    else
        begin
          couleurs(15, 0);
          pos.x := 35;
          pos.y := 27;
          ecrireEnPosition(pos, 'Retour au menu marchand');
        end
    ;
    couleurs(15, 0);
    deplacerCurseurXY(0, 0);
  until ch = #13;
  menuAchat := select;
end;

// cette fonction demande à l'utilisateur si il veut vraiment acheter l'objet
function menuAffichageAchat(index:integer) : Integer;
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  ascii('achat_affichage', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
  dessinerCadreXY(2,11,118,14,double,255,0);
  pos.x := 47;
  pos.y := 12;
  ecrireEnPosition(pos, 'Voulez vous vraiment acheter');
  pos.x := 47;
  pos.y := 13;
  ecrireEnPosition(pos, concat('un(e) ', tabProduits[index].nom));
  dessinerCadreXY(29,24,90,26,double,255,0);
  couleurs(0, 15);
  pos.x := 31;
  pos.y := 25;
  ecrireEnPosition(pos, 'Oui');
  couleurs(15, 0);
  pos.x := 86;
  pos.y := 25;
  ecrireEnPosition(pos, 'Non');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
        select := select + 1;
        if (select >= 2) then
          select := 1;
      end;
      'M':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 31;
        pos.y := 25;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 86;
        pos.y := 25;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 86;
        pos.y := 25;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 31;
        pos.y := 25;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuAffichageAchat := select;
end;

// procedure qui confirme l'achat d'un objet et l'ajoute dans l'inventaire
procedure menuValidationAchat(index:integer);
var
   e : string;
   i : item;
   ch : char;
begin
  effacerEcran();
  ascii('achat_affichage', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour revenir');
  dessinerCadreXY(2,11,118,14,double,255,0);
  if hasMoney(tabProduits[index].prixAchat) then
  begin
    pos.x := 47;
    pos.y := 12;
    ecrireEnPosition(pos, concat('votre ', tabProduits[index].nom, ' est dans votre inventaire'));
    i.id := tabProduits[index].id;
    i.count := 1;
    addItemInventory(i);
    delMoney(tabProduits[index].prixAchat);
  end
  else
  begin
    pos.x := 30;
    pos.y := 12;
    ecrireEnPosition(pos, concat('vous n''avez pas assez d''argent pour un(e) ', tabProduits[index].nom));
    pos.x := 50;
    pos.y := 13;
    ecrireEnPosition(pos, concat('vous n''avez que ', InttoStr(getMoney()), ' E'));
  end;
  deplacerCurseurXY(0, 0);
  repeat
    ch := ReadKey;
  until ch = #13;
end;

// fonction qui sert à valider la vente de l'objet
{function validationVente(index:integer):Integer;
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('vente_valid', 0, 0);
  pos.x := 4;
  pos.y := 1;
  ecrireEnPosition(pos, 'Deposer un objet (sauf arme et armure)');
  couleurs(15, 0);
  pos.x := 93;
  pos.y := 27;
  ecrireEnPosition(pos, 'Retour au menu marchand');
  pos.x := 17;
  pos.y := 10;
  ecrireEnPosition(pos, 'Inventaire');
  pos.x := 3;
  pos.y := 27;
  ecrireEnPosition(pos, 'Valider la vente');
  deplacerCurseurXY(0, 0);
  select := 4;


  pos.x := 74;
  pos.y := 1;
  deplacerCurseur(pos);
  write('Voulez vous vraiment vendre cette ', tabProduits[index].nom);
  couleurs(0, 15);
  pos.x := 70;
  pos.y := 22;
  ecrireEnPosition(pos, 'Oui');
  couleurs(15, 0);
  pos.x := 113;
  pos.y := 22;
  ecrireEnPosition(pos, 'Non');
  deplacerCurseurXY(0, 0);
  select := 4;

  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
          select := 4;
      end;
      'M':
      begin
          select := 5;
      end;
    end;
    case select of
      4:
      begin
        couleurs(0, 15);
        pos.x := 70;
        pos.y := 22;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 113;
        pos.y := 22;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
      5:
      begin
        couleurs(0, 15);
        pos.x := 113;
        pos.y := 22;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 70;
        pos.y := 22;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  validationVente := select;

end;

// procedure qui retourne que l'objet est vendu et le retire de l'inventaire
procedure UI(index:integer);
var
   e:string;
begin
  effacerEcran();
  ascii('marchand_achat', 0, 0);
  pos.x := 46;
  pos.y := 13;
  ecrireEnPosition(pos, 'votre objet est bien vendu');
  deplacerCurseurXY(0, 0);
  addMoney(tabProduits[index].prixVente);
  removeItemInventory(tabProduits[index].id, 1);
  readln(e);
  if (e = '')then //vente(index)
  else UI(index);
end;}

end.

