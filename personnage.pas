unit personnage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uniteforge;

const
  NOMBRE_INV_JEU = 10;

type
  TypeSexe = (m, f);
  TypeEquipement = Array[1..4] of Item;
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

procedure removeItemInventory();
begin
  writeln(length(inventaire));
end;

{procedure addItemInventory();
begin

end;

procedure setItemInventory();
begin

end;
}

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

