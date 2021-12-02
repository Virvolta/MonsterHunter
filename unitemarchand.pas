unit uniteMarchand;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,ihm,logique,uniteObjets,outils,personnage, controle,uniteforge;

function menuMarchand(): Integer;
function menuVente():Integer;
function menuAchat():Integer;
function potion(index:integer) : Integer;
procedure Oui(index:integer);
function validationVente(index:integer):Integer;
procedure UI(index:integer);

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
  ascii('marchant', 0, 0);
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
   select: integer;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('vente', 0, 0);
  pos.x := 4;
  pos.y := 1;
  ecrireEnPosition(pos, 'Deposer un objet (sauf arme et armure)');
  couleurs(0, 15);
  pos.x := 93;
  pos.y := 27;
  ecrireEnPosition(pos, 'Retour au menu marchand');
  couleurs(15,0);
  pos.x := 17;
  pos.y := 10;
  ecrireEnPosition(pos, 'Inventaire');
  pos.x := 3;
  pos.y := 27;
  ecrireEnPosition(pos, 'Valider la vente');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'K':
      begin
        select := 3;
      end;
      'M':
      begin
        select := 1;
      end;
      'P':
      begin
        select := select + 1;
        if (select = 2) then
           select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select = 1) then
           select := 2;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 93;
        pos.y := 27;
        ecrireEnPosition(pos, 'Retour au menu marchand');
        couleurs(15,0);
        pos.x := 17;
        pos.y := 10;
        ecrireEnPosition(pos, 'Inventaire');
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Valider la vente');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 17;
        pos.y := 10;
        ecrireEnPosition(pos, 'Inventaire');
        couleurs(15,0);
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Valider la vente');
        pos.x := 93;
        pos.y := 27;
        ecrireEnPosition(pos, 'Retour au menu marchand');
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 3;
        pos.y := 27;
        ecrireEnPosition(pos, 'Valider la vente');
        couleurs(15,0);
        pos.x := 93;
        pos.y := 27;
        ecrireEnPosition(pos, 'Retour au menu marchand');
        pos.x := 17;
        pos.y := 10;
        ecrireEnPosition(pos, 'Inventaire');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  menuVente := select;


end;

// cette fonction liste tout les objets que le joueur peux acheter
function menuAchat():Integer;
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  couleurs(15, 0);
  ascii('marchand_achat', 0, 0);
  pos.x := 46;
  pos.y := 3;
  deplacerCurseurXY(pos.x, pos.y);
  write('Que voulez-vous acheter ', getpseudo);
  couleurs(0, 15);
  pos.x := 35;
  pos.y := 7;
  deplacerCurseur(pos);
  write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat);
  couleurs(15, 0);
  pos.x := 35;
  pos.y := 9;
  deplacerCurseur(pos);
  write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat);
  pos.x := 35;
  pos.y := 11;
  deplacerCurseur(pos);
  write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat);
  pos.x := 35;
  pos.y := 13;
  deplacerCurseur(pos);
  write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat);
  pos.x := 35;
  pos.y := 15;
  deplacerCurseur(pos);
  write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat);
  pos.x := 35;
  pos.y := 17;
  deplacerCurseur(pos);
  write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat);
  pos.x := 35;
  pos.y := 19;
  deplacerCurseur(pos);
  write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat);
  pos.x := 35;
  pos.y := 23;
  ecrireEnPosition(pos, 'Retour au menu marchand');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat
    ch := ReadKey;
    case ch of
      'P':
      begin
        select := select + 1;
        if (select >= 9) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 8;
      end;
    end;
    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat);
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat);
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat);
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat);
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat);
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat);
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat);
        pos.x := 35;
        pos.y := 23;
        ecrireEnPosition(pos, 'Retour au menu marchand');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat);
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat);
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat);
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat);
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand');
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat);
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat);
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        deplacerCurseurXY(0, 0);
      end;
      4:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat );
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        deplacerCurseurXY(0, 0);
      end;
      5:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat );
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        deplacerCurseurXY(0, 0);
      end;
      6:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat );
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        deplacerCurseurXY(0, 0);
    end;
      7:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat );
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        deplacerCurseurXY(0, 0);
    end;
      8:
      begin
        couleurs(0, 15);
        pos.x := 35;
        pos.y := 23;
        deplacerCurseur(pos);
        write('Retour au menu marchand' );
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 7;
        deplacerCurseur(pos);
        write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat );
        pos.x := 35;
        pos.y := 9;
        deplacerCurseur(pos);
        write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat );
        pos.x := 35;
        pos.y := 11;
        deplacerCurseur(pos);
        write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat );
        pos.x := 35;
        pos.y := 13;
        deplacerCurseur(pos);
        write(tabProduits[7].nom,' : ', tabProduits[7].prixAchat );
        pos.x := 35;
        pos.y := 15;
        deplacerCurseur(pos);
        write(tabProduits[8].nom,' : ', tabProduits[8].prixAchat );
        pos.x := 35;
        pos.y := 17;
        deplacerCurseur(pos);
        write(tabProduits[9].nom,' : ', tabProduits[9].prixAchat );
        pos.x := 35;
        pos.y := 19;
        deplacerCurseur(pos);
        write(tabProduits[10].nom,' : ', tabProduits[10].prixAchat );
        deplacerCurseurXY(0, 0);
    end;
  end;
  until ch = #13;
  menuAchat := select;

end;

// cette fonction demande à l'utilisateur si il veut vraiment acheter l'objet
function potion(index:integer) : Integer;
var
   ch: char;
   i: integer;
   select: integer;
begin
  effacerEcran();
  dessinerCadreXY(2,14,118,16,double,255,0);
  dessinerCadreXY(2,27,118,29,double,255,0);
  pos.x := 40;
  pos.y := 15;
  deplacerCurseur(pos);
  write('Voulez vous vraiment acheter cette ', tabProduits[index].nom);
  couleurs(0, 15);
  pos.x := 30;
  pos.y := 28;
  ecrireEnPosition(pos, 'Oui');
  couleurs(15, 0);
  pos.x := 80;
  pos.y := 28;
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
        pos.x := 30;
        pos.y := 28;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 80;
        pos.y := 28;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 80;
        pos.y := 28;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 30;
        pos.y := 28;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;
  Potion := select;


end;

// procedure qui confirme l'achat d'un objet et l'ajoute dans l'inventaire
procedure Oui(index:integer);
var
   e:string;
   i:item;
begin
  effacerEcran();
  if hasMoney(tabProduits[index].prixAchat) then
  begin
    dessinerCadreXY(38,2,86,25,simple,255,0);
    pos.x := 43;
    pos.y := 13;
    ecrireEnPosition(pos, 'votre objet est dans votre inventaire');
    i.id := tabProduits[index].id;
    i.count := 1;
    addItemInventory(i);
    delMoney(tabProduits[index].prixAchat);
  end
  else
  begin
    pos.x := 54;
    pos.y := 13;
    deplacerCurseurXY(pos.x, pos.y);
    write('vous n''avez que ', getMoney);
  end;
  readln(e);
  if (e = '')then achat()
  else Oui(index);
end;

// fonction qui sert à valider la vente de l'objet
function validationVente(index:integer):Integer;
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
  if (e = '')then vente(index)
  else UI(index);
end;

end.

