unit uniteforge;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  item=record
    id: Integer;
    count:Integer;
    unique:Boolean;
  end;

function getCraftResult(item1,item2:item):item;

implementation

function getCraftResult(item1,item2:item):item;

var

  itemResult:item;

{const

  1="Cuir"
  2="Fer"
  3="Aeter"
  4="Bois"

  10="Epee en bois" 3bois
  11="Epee en fer" bois+2fer
  12="Epee en Aeter" bois+2aeter

  20="Casque en cuir" 5cuir
  21="Casque en fer" 5fer
  22="Casque en Aeter" 5aeter

  30="Torse en cuir" 8cuir
  31="Torse en fer" 8fer
  32="Torse en Aeter" 8aeter

  40="Jambières en cuir" 7cuir
  41="Jambières en fer" 7fer
  42="Jambières en Aeter" 7aeter

  50="Bottes en cuir" 4cuir
  51="Bottes en fer" 4fer
  52="Bottes en Aeter" 4aeter

  60="Gants en cuir" 2cuir
  61="Gants en fer" 2fer
  62="Gants en Aeter" 2aeter

}

begin
  itemResult.id := 0;

  //Epee

  //Epee bois
  if (
  ((item1.id = 4) and (item1.count >= 3))
  or
  ((item2.id = 4) and (item2.count >= 3))
  or
  ((item1.id = 4) and (item2.id = 4) and (item1.count + item2.count >= 3))
  )
  then
  begin
     itemResult.id:=10;
     itemResult.count:=1;
  end
  //Epee fer
  else if (
  ((item1.id = 4) and (item1.count >= 1))
  or
  ((item2.id = 4) and (item2.count >= 1))
  and
  (((item1.id = 2) and (item1.count >= 2)) or ((item2.id = 2) and (item2.count >= 2)))
  )
  then
  begin
     itemResult.id:=50;
     itemResult.count:=1;
  end
  ;

  getCraftResult:=itemResult;
end;

end.


