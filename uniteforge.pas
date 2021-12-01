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

// cette fonction donne tout les crafts possible
function getCraftResult(item1,item2:item):item;

var

  itemResult:item;

{const

    1="Cuir"
    2="Fer"
    3="Aeter"
    4="Bois"

    14="Epee en bois" 3bois
    12="Epee en fer" bois+2fer
    13="Epee en Aeter" bois+2aeter

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

  itemResult.id:=0;

  //Item = Cuir
  if (item1.id=1) and (item2.id=1) then
     begin
       //5 Cuir = Casque en Cuir
       if (item1.count+item2.count=5) then
          begin
               itemResult.id:=20;
               itemResult.count:=1;
          end
       //8 Cuir = Torse en Cuir
       else if (item1.count+item2.count=8) then
          begin
               itemResult.id:=30;
               itemResult.count:=1;
          end
       //7 Cuir = Jambières en Cuir
       else if (item1.count+item2.count=7) then
          begin
               itemResult.id:=40;
               itemResult.count:=1;
          end
       //4 Cuir = Bottes en Cuir
       else if (item1.count+item2.count=4) then
          begin
               itemResult.id:=50;
               itemResult.count:=1;
          end
       //2 Cuir = Gants en Cuir
       else if (item1.count+item2.count=2) then
          begin
               itemResult.id:=60;
               itemResult.count:=1;
          end
     end

  //Item = Fer
  else if (item1.id=2) and (item2.id=2) then
     begin
       //5 Fer = Casque en Fer
       if (item1.count+item2.count=5) then
          begin
            itemResult.id:=21;
            itemResult.count:=1;
          end
         //8 Fer = Torse en Fer
       else if (item1.count+item2.count=8) then
          begin
            itemResult.id:=31;
            itemResult.count:=1;
          end
         //7 Fer = Jambières en Fer
       else if (item1.count+item2.count=7) then
          begin
            itemResult.id:=41;
            itemResult.count:=1;
          end
         //4 Fer = Bottes en Fer
       else if (item1.count+item2.count=4) then
          begin
            itemResult.id:=51;
            itemResult.count:=1;
          end
         //2 Fer = Gants en Fer
       else if (item1.count+item2.count=2) then
          begin
            itemResult.id:=61;
            itemResult.count:=1;
          end

     end

  //Item = Aeter
  else if (item1.id=3) and (item2.id=3) then
     begin
       //5 Aeter = Casque en Aeter
       if (item1.count+item2.count=5) then
          begin
            itemResult.id:=22;
            itemResult.count:=1;
          end
         //8 Aeter = Torse en Aeter
       else if (item1.count+item2.count=8) then
          begin
            itemResult.id:=32;
            itemResult.count:=1;
          end
         //7 Aeter = Jambières en Aeter
       else if (item1.count+item2.count=7) then
          begin
            itemResult.id:=42;
            itemResult.count:=1;
          end
         //4 Aeter = Bottes en Aeter
       else if (item1.count+item2.count=4) then
          begin
            itemResult.id:=52;
            itemResult.count:=1;
          end
         //2 Fer = Gants en Aeter
       else if (item1.count+item2.count=2) then
          begin
            itemResult.id:=62;
            itemResult.count:=1;
          end
     end

  else if (item1.id=4) and (item2.id=4) then
     //Item = Bois
     begin
       if (item1.count+item2.count=3) then
          begin
            itemResult.id:=14;
            itemResult.count:=1;
          end
     end
  else if ((item1.id=4) and (item2.id=2)) or ((item1.id=2) and (item2.id=4)) then
     begin
       if ((item1.id=4) and (item1.count=1)) and ((item2.id=2) and (item2.count=2)) then
          begin
            itemResult.id:=12;
            itemResult.count:=1;
          end
       else if ((item1.id=2) and (item1.count=2)) and ((item2.id=4) and (item2.count=1)) then
          begin
            itemResult.id:=12;
            itemResult.count:=1;
          end
     end
  else if ((item1.id=4) and (item2.id=3)) or ((item1.id=3) and (item2.id=4)) then
     begin
       if ((item1.id=4) and (item1.count=1)) and ((item2.id=3) and (item2.count=2)) then
          begin
            itemResult.id:=13;
            itemResult.count:=1;
          end
       else if ((item1.id=3) and (item1.count=2)) and ((item2.id=4) and (item2.count=1)) then
          begin
            itemResult.id:=13;
            itemResult.count:=1;
          end
     end;
  getCraftResult:=itemResult;
end;

end.


