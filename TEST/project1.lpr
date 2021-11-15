program project1;

begin
  procedure Menu;
  var b:byte; boucle:boolean;
  begin
  writeln('******************************');
  writeln('* PROGRAMME DE MATHEMATIQUES *');
  writeln('******************************');
  writeln;
  writeln('1. ADDITION');
  writeln('2. SOUSTRACTION');
  writeln('3. MULTIPLICATION');
  writeln;
  boucle:=true;
  while boucle do
        begin
        boucle:=false;
        write('Choix : ');
        readln(b);
        writeln;
        case b of
             1:Addition;
             2:Soustraction;
             3:Multiplication;
             else boucle:=true;
             end;
        end;
  end;
end.

