unit personnage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uniteforge, outils;

const
  NOMBRE_INV_JEU = 10;
  MAX_HEART = 200;

type
  TypeSexe = (m, f);
  TypeEquipement = Array[1..6] of Item;
  TypeInventaire = Array[1..NOMBRE_INV_JEU] of Item;

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

procedure removeItemEquipement(i : integer);
function getItemEquipement(i : integer) : Item;
function addItemEquipement(i : Item) : Item;

procedure removeItemInventory(id,count : integer);
function getSlotItemNullInventory() : Integer;
procedure addItemInventory(i : Item);
procedure setItemInventory(slot : Integer; i : Item);
function hasItemInventory(id,count : integer) : boolean;

implementation

var
   pseudo : String;
   sexe : TypeSexe;
   taille, poid :Integer;
   money : Integer;
   equipement : TypeEquipement;
   inventaire : TypeInventaire;
   heart : integer;

function getEquipement() : TypeEquipement;
begin
  getEquipement := equipement;
end;

function getInventory() : TypeInventaire;
begin
  getInventory := inventaire;
end;

procedure removeItemEquipement(i : integer);

begin
  equipement[i].id := 0;
  equipement[i].count := 0;
end;

function getItemEquipement(i : integer) : Item;

begin
  getItemEquipement := equipement[i];
end;

function addItemEquipement(i : Item) : Item;

var
   slot : Integer;
begin
  slot := tabEquipments[tabIdEquipments[i.id]].slot;
  addItemInventory(i);
  inventaire[slot] := i;
end;

procedure removeItemInventory(id,count : integer);

var
   i : Integer;

begin
  for i := 1 to length(inventaire) do
      begin
        if ((inventaire[i].id = id) or (inventaire[i].count = count)) then
        begin
          if (inventaire[i].count >= count) then
            begin
              inventaire[i].count := inventaire[i].count - count;
              inventaire[i].id := 0;
              break;
            end
          else
              count := count - inventaire[i].count;
              inventaire[i].count := 0;
              inventaire[i].id := 0;
          ;
        end;
      end;
end;

function hasItemInventory(id,count : integer) : boolean;

var
   i : Integer;
   b : boolean;

begin
  b:= false;
  for i := 1 to length(inventaire) do
      begin
        if ((inventaire[i].id = id) or (inventaire[i].count = count)) then
        begin
          if (inventaire[i].count >= count) then
            begin
              b := true;
              break;
            end
          else
              count := count - inventaire[i].count;
          ;
        end;
      end;
  hasItemInventory := b;
end;

function getSlotItemNullInventory() : Integer;

var
   i : Integer;
begin
  for i := 1 to length(inventaire) do
      begin
        if ((inventaire[i].id <= 0) or (inventaire[i].count <= 0)) then
           begin
             getSlotItemNullInventory := i;
             break;
           end;
      end;
end;

procedure addItemInventory(i : Item);

var
   slot : Integer;
   n : Integer;
   b : boolean;

begin
  b := true;
  if ((i.id <= 0) or (i.count <= 0)) then
     b := false
  ;

  if (b = true) then
     for n := 1 to length(inventaire) do
      begin
        if ((inventaire[n].id = i.id) and (inventaire[n].unique = false))then
           begin
             inventaire[n].count := inventaire[n].count + i.count;
             b:=false;
             break;
           end;
      end;
  ;
  if (b = true) then
     inventaire[getSlotItemNullInventory()] := i
  ;
end;

procedure setItemInventory(slot : Integer; i : Item);
begin
   inventaire[slot] := i;
end;

function getMoney() : Integer;

begin
  getMoney := money;
end;

procedure setMoney(m : Integer);

begin
  money := m;
end;

procedure addMoney(m : Integer);

begin
  money := money + m;
end;

procedure delMoney(m : Integer);

begin
  money := money - m;
end;

function hasMoney(m : Integer) : boolean;

begin
  if (money - m >= 0) then
    hasMoney := true
  else
    hasMoney := false;
  ;
end;

function getPseudo() : String;

begin
   getPseudo := pseudo;
end;

procedure setPseudo(n : String);
begin
   pseudo := n;
end;

function getSexe() : TypeSexe;

begin
   getSexe := sexe;
end;

function getSexeString() : String;

begin
   if(sexe = m) then
       getSexeString := 'homme'
   else
       getSexeString := 'femme';
end;

procedure setSexe(n : TypeSexe);
begin
   sexe := n;
end;

function getTaille() :Integer;

begin
   getTaille := taille;
end;

procedure setTaille(n :Integer);
begin
   taille := n;
end;

function getPoid() :Integer;

begin
   getPoid:= poid;
end;

procedure setPoid(n :Integer);
begin
   poid := n;
end;

procedure addHeart(amount : Integer);

begin
  if (heart + amount > MAX_HEART) then
     heart := MAX_HEART
  else
      heart := heart + amount
  ;
end;

procedure removeHeart(amount : Integer);

begin
  if (heart - amount < 0) then
     heart := 0
  else
      heart := heart - amount
  ;
end;

end.

