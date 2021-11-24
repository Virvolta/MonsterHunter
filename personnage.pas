unit personnage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uniteforge;

const
  NOMBRE_INV_JEU = 10;

type
  TypeSexe = (m, f);
  TypeEquipement = Array[1..5] of Item;
  TypeInventaire = Array[1..NOMBRE_INV_JEU] of Item;

function getPseudo() : String;
procedure setPseudo(n : String);

function getSexe() : TypeSexe;
function getSexeString() : String;
procedure setSexeChar(n : Char);
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

function getEquipement() : TypeEquipement;
begin
  getEquipement := equipement;
end;

function getInventory() : TypeInventaire;
begin
  getInventory := inventaire;
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
  for n := 1 to length(inventaire) do
      begin
        if ((inventaire[n].id = i.id) and (inventaire[n].unique = false))then
           begin
             inventaire[n].count := inventaire[n].count + i.count;
             b:=false;
             break;
           end;
      end;
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

procedure setSexeChar(n : Char);

begin
  if (LowerCase(n) = 'm') then
     sexe := m
  else
     sexe := f
  ;
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

end.

