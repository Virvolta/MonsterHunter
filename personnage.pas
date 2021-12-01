unit personnage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uniteforge, outils;

const
  NOMBRE_INV_JEU = 10;
  NOMBRE_ARMOIRE_JEU = 10;
  MAX_HEART = 200;

type
  TypeSexe = (m, f);
  TypeEquipement = Array[1..6] of Item;
  TypeInventaire = Array[1..NOMBRE_INV_JEU] of Item;
  TypeArmoire = Array[1..NOMBRE_ARMOIRE_JEU] of Item;

function getPseudo() : String;
procedure setPseudo(n : String);

function getSexe() : TypeSexe;
function getSexeString() : String;
procedure setSexe(n : TypeSexe);

function getTaille() :Integer;
procedure setTaille(n :Integer);

function getPoid() :Integer;
procedure setPoid(n :Integer);

function getMoney() : Integer;
procedure setMoney(m : Integer);
procedure addMoney(m : Integer);
procedure delMoney(m : Integer);
function hasMoney(m : Integer) : boolean;

function getInventory() : TypeInventaire;
function getEquipement() : TypeEquipement;
function getArmoire() : TypeArmoire;

procedure removeItemEquipement(i : integer);
function getItemEquipement(i : integer) : Item;
procedure addItemEquipement(i : Item);

procedure removeItemInventory(id,count : integer);
function getSlotItemNullInventory() : Integer;
function addItemInventory(i : Item) : boolean;
procedure setItemInventory(slot : Integer; i : Item);
function getItemInventory(slot : Integer) : Item;
function hasItemInventory(id,count : integer) : boolean;

procedure addHeart(amount : Integer);
procedure removeHeart(amount : Integer);
procedure setHeart(amount : Integer);
function getHeart():Integer;

implementation

var
   pseudo : String;
   sexe : TypeSexe;
   taille, poid :Integer;
   money : Integer;
   equipement : TypeEquipement;
   inventaire : TypeInventaire;
   armoire : TypeArmoire;
   heart : integer;

// cette fonction montre l'equipement du joueur
function getEquipement() : TypeEquipement;
begin
  getEquipement := equipement;
end;

// cette fonction montre l'inventaire du joueur
function getInventory() : TypeInventaire;
begin
  getInventory := inventaire;
end;

// cette fonction montre l'armoire
function getArmoire() : TypeArmoire;
begin
  getArmoire := armoire;
end;

// cette procedure enleve un item de l'inventaire
procedure removeItemEquipement(i : integer);

begin
  equipement[i].id := 0;
  equipement[i].count := 0;
end;

// cette fonction montre les equipements
function getItemEquipement(i : integer) : Item;

begin
  getItemEquipement := equipement[i];
end;

// cette procedure ajoute un item dans equipement
procedure addItemEquipement(i : Item);

var
   slot : Integer;
begin
  slot := tabEquipments[tabIdEquipments[i.id]].slot;
  equipement[slot] := i;
end;

// cette procedure enleve un item de l'inventaire
procedure removeItemInventory(id,count : integer);

var
   i : Integer;
   b : boolean;

begin
  i := 1;
  b := false;
  repeat
    if (inventaire[i].id = id) then
        begin
          if (inventaire[i].count >= count) then
            begin
              inventaire[i].count := inventaire[i].count - count;
              inventaire[i].id := 0;
              b := true;
            end
          else
              begin
                 count := count - inventaire[i].count;
                 inventaire[i].count := 0;
                 inventaire[i].id := 0;
              end
          ;
        end;
    i := i +1;
  until (b = true) or (i >= length(inventaire));
end;

// cette fonction verifie si vous avez l'objet dans votre inventaire ou non
function hasItemInventory(id,count : integer) : boolean;

var
   i : Integer;
   b : boolean;

begin
  i := 1;
  b := false;
  repeat
    if ((inventaire[i].id = id)) then
        begin
          if (inventaire[i].count >= count) then
            begin
              b := true;
            end;
        end;
    i := i +1;
  until (b = true) or (i >= length(inventaire));
  hasItemInventory := b;
end;

// cette fonction permet de regarder quel slot est libre dans l'inventaire
function getSlotItemNullInventory() : Integer;

var
   i : Integer;
   c : Integer;
   b : boolean;
begin
  i := 1;
  c := -1;
  b := false;
  repeat
   if ((inventaire[i].id <= 0) or (inventaire[i].count <= 0)) then
           begin
             c := i;
             b := true;
           end;
    i := i +1;
  until (b = true) or (i >= length(inventaire));
  getSlotItemNullInventory := c;
end;

// cette fonction ajoute un item dans l'inventaire
function addItemInventory(i : Item) : boolean;

var
   n : Integer;
   b : boolean;

begin
  b := true;
  if ((i.id <= 0) or (i.count <= 0)) then
     b := false
  else
     begin
        n := 1;
        b := false;
        repeat
           if ((inventaire[n].id = i.id) and (inventaire[n].unique = false))then
             begin
                  inventaire[n].count := inventaire[n].count + i.count;
                  b:= true;
             end;
            n := n + 1;
        until (b = true) or (n > high(inventaire))
     end;
  if (b = false) then
    begin
     n := getSlotItemNullInventory();
     if (getSlotItemNullInventory() > 0) then
       begin
          inventaire[n] := i;
          b := true;
       end
     else
         b:= false
     ;
    end;
  addItemInventory := b;
end;

// cette procedure permet de mettre de force un objet dans l'inventaire
procedure setItemInventory(slot : Integer; i : Item);
begin
   inventaire[slot] := i;
end;

// cette fonction permet de vous donnez un item en fonction d'un slot dans l'inventaire
function getItemInventory(slot : Integer) : Item;
begin
   getItemInventory := inventaire[slot];
end;

// cette fonction permet d'afficher la money disponible par le joueur
function getMoney() : Integer;

begin
  getMoney := money;
end;

// cette procedure permet de definire de force combient d'argent à le joueur
procedure setMoney(m : Integer);

begin
  money := m;
end;

// cette procedure permet d'ajouter de l'argent au joueur
procedure addMoney(m : Integer);

begin
  money := money + m;
end;

// cette procedure permet de supprimer de l'argent au joueur
procedure delMoney(m : Integer);

begin
  money := money - m;
end;

// cette fonction permet de verifier si le joueur a l'argent disponible
function hasMoney(m : Integer) : boolean;

begin
  if (money - m >= 0) then
    hasMoney := true
  else
    hasMoney := false;
  ;
end;

// cette fonction permet d'afficher le pseudo du joueur
function getPseudo() : String;

begin
   getPseudo := pseudo;
end;

// cette procedure permet d'enregistrer le pseudi du joueur
procedure setPseudo(n : String);
begin
   pseudo := n;
end;

// cette function permet de connaitre le sexe du joueur
function getSexe() : TypeSexe;

begin
   getSexe := sexe;
end;

// cette function permet de focer l'utilisateur de choisir entre homme et femme
function getSexeString() : String;

begin
   if(sexe = m) then
       getSexeString := 'homme'
   else
       getSexeString := 'femme';
end;

// cette procedure enregistre le sexe du joueur
procedure setSexe(n : TypeSexe);
begin
   sexe := n;
end;

// cette fonction demande a l'utilisteur de rentrer la taille du perso
function getTaille() :Integer;

begin
   getTaille := taille;
end;

// cette procedure permet d'enregistrer la taille du joueur
procedure setTaille(n :Integer);
begin
   taille := n;
end;

// cette fonction demande a l'utilisateur de rentrer le poid de son perso
function getPoid() :Integer;

begin
   getPoid:= poid;
end;

// cette procedure enregistre le poid du perso
procedure setPoid(n :Integer);
begin
   poid := n;
end;

// cette procedure defini les HP du joueur
procedure setHeart(amount : Integer);

begin
  heart := amount;
end;

// cette procedure permet d'ajouter des HP au joueur
procedure addHeart(amount : Integer);

begin
  if (heart + amount > MAX_HEART) then
     heart := MAX_HEART
  else
      heart := heart + amount
  ;
end;

// cette procedure permet d'enlever des HP au joueur
procedure removeHeart(amount : Integer);

begin
  if (heart - amount < 0) then
     heart := 0
  else
      heart := heart - amount
  ;
end;

// cette fonction permet de montre les HP du joueur
function getHeart():Integer;

begin

  getHeart:=heart;

end;

end.

