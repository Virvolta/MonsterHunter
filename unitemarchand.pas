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

function menuVente():Integer;
var
   h: integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 93;
  pos.y := 1;
  ecrireEnPosition(pos, '3)Retour au menu marchand');
  pos.x := 4;
  pos.y := 4;
  ecrireEnPosition(pos, 'Deposer un objet (sauf arme et armure)');
  dessinerCadreXY(16,12,35,18,simple,255,0);
  pos.x := 17;
  pos.y := 19;
  ecrireEnPosition(pos, 'Appyuer sur 1 pour ');
  pos.X := 14;
  pos.y :=20;
  ecrireEnPosition(pos, 'entrer dans l''inventaire ');
  pos.x := 3;
  pos.y := 1;
  ecrireEnPosition(pos, '2)Valider la vente');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(h);
  menuVente := h;

end;

function menuAchat():Integer;
var
   a:integer;
begin
  effacerEcran();
  dessinerCadreXY(20,3,100,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 50;
  pos.y := 1;
  ecrireEnPosition(pos, '8)Retour au menu marchand');
  pos.x := 52;
  pos.y := 4;
  ecrireEnPosition(pos, 'Acheter des objets : ');
  pos.x := 35;
  pos.y := 9;
  deplacerCurseur(pos);
  write(tabProduits[0].nom,' : ', tabProduits[0].prixAchat);
  pos.x := 35;
  pos.y := 11;
  deplacerCurseur(pos);
  write(tabProduits[1].nom,' : ', tabProduits[1].prixAchat);
  pos.x := 35;
  pos.y := 13;
  deplacerCurseur(pos);
  write(tabProduits[2].nom,' : ', tabProduits[2].prixAchat);
  pos.x := 35;
  pos.y := 15;
  deplacerCurseur(pos);
  write(tabProduits[3].nom,' : ', tabProduits[3].prixAchat);
  pos.x := 35;
  pos.y := 17;
  deplacerCurseur(pos);
  write(tabProduits[4].nom,' : ', tabProduits[4].prixAchat);
  pos.x := 35;
  pos.y := 19;
  deplacerCurseur(pos);
  write(tabProduits[5].nom,' : ', tabProduits[5].prixAchat);
  pos.x := 35;
  pos.y := 21;
  deplacerCurseur(pos);
  write(tabProduits[6].nom,' : ', tabProduits[6].prixAchat);

  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(a);
  menuAchat := a;

end;

function potion(index:integer) : Integer;
var
   p:Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,14,118,16,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  pos.x := 40;
  pos.y := 15;
  deplacerCurseur(pos);
  write('Voulez vous vraiment acheter cette ', tabProduits[index].nom);
  pos.x := 30;
  pos.y := 28;
  ecrireEnPosition(pos, '1) Oui');
  pos.x := 80;
  pos.y := 28;
  ecrireEnPosition(pos, '2) Non');
  pos.x := 55;
  pos.y := 28;
  ecrireEnPosition(pos, 'choix : ');
  readln(p);
  potion := p;

end;

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

function validationVente(index:integer):Integer;
var
   v:Integer;
begin
  effacerEcran();
  dessinerCadreXY(2,3,50,26,simple,255,0);
  dessinerCadreXY(2,27,118,29,simple,255,0);
  dessinerCadreXY(2,0,118,2,simple,255,0);
  pos.x := 93;
  pos.y := 1;
  ecrireEnPosition(pos, '3)Retour au menu marchand');
  pos.x := 4;
  pos.y := 4;
  ecrireEnPosition(pos, 'Deposer un objet (sauf arme et armure)');
  dessinerCadreXY(16,12,35,18,simple,255,0);
  pos.x := 17;
  pos.y := 19;
  ecrireEnPosition(pos, 'Appyuer sur 1 pour ');
  pos.X := 14;
  pos.y :=20;
  ecrireEnPosition(pos, 'entrer dans l''inventaire ');
  pos.x := 3;
  pos.y := 1;
  ecrireEnPosition(pos, '2)Valider la vente');


  dessinerCadreXY(70,3,118,26,simple,255,0);
  pos.x := 78;
  pos.y := 4;
  deplacerCurseur(pos);
  write('Voulez vous vraiment vendre cette ');
  pos.x := 82;
  pos.y := 5;
  deplacerCurseur(pos);
  write(tabProduits[index].nom);
  pos.x := 85;
  pos.y := 15;
  deplacerCurseur(pos);
  write('Son prix est de ', tabProduits[index].prixVente);
  pos.x := 71;
  pos.y := 25;
  ecrireEnPosition(pos, '4)Oui');
  pos.x := 112;
  pos.y := 25;
  ecrireEnPosition(pos, '5)Non');
  pos.x := 56;
  pos.y := 28;
  ecrireEnPosition(pos, 'Choix : ');
  readln(v);
  validationVente := v;

end;

procedure UI(index:integer);
var
   e:string;
begin
  effacerEcran();
  dessinerCadreXY(38,2,86,25,simple,255,0);
  pos.x := 50;
  pos.y := 13;
  ecrireEnPosition(pos, 'votre objet est bien vendu');
  addMoney(tabProduits[index].prixVente);
  removeItemInventory(tabProduits[index].id, 1);
  readln(e);
  if (e = '')then vente(index)
  else UI(index);
end;

end.

