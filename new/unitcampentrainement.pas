unit unitCampEntrainement;

{$mode ObjFPC}{$H+}

interface
uses unitLieu,unitPersonnage;

var
  deg : boolean;
  bouc : boolean;
  lout : boolean;

function campHub(): typeLieu;
function grosDegats():typeLieu;
function bouclier():typeLieu;
function louteur():typeLieu;


implementation
uses
  unitIHM,GestionEcran;

var
  pos : coordonnees ;
  i: integer = 0;
  j: integer = 0;
  k: integer = 0;

function campHub(): typeLieu;
var choix : string;
begin
choix := '';
  while (choix <> '1') and (choix <> '2') and (choix <> '3') and (choix <> '4') do
  begin
    afficherInterfacePrincipale();
    afficherLieu('Camp d''entrainement');

    deplacerCurseurXY(30,7);write('Vous êtes dans le camp d''entrainement. Un monsieur dont vous ne pouver pas distinger le visage');
    deplacerCurseurXY(30,8);write('vous propose d''apprendre des technique secretes qui pourrait etre utile lors de combat, mais');
    deplacerCurseurXY(30,9);write('bien sur ces secrets on un couts.');

    deplacerCurseurXY(30,11);write('Il vous propose d''apprendre un secret qui vous permettra de faire de plus gros degtas que d''habitude.');

    deplacerCurseurXY(30,13);write('La competence s''appelle gros degat et pour la maitriser completement vous devez :');
    deplacerCurseurXY(30,14);write('Payer 600 d''or');
    deplacerCurseurXY(30,15);write('Faire 4 entrainements');

    deplacerCurseurXY(30,17);write('Il vous propose ensuite un secret qui vous permettra de vous proteger plus facilement lors d''attaque contre vous.');

    deplacerCurseurXY(30,19);write('La competence s''appelle bouclier et pour la maitriser completement vous devez :');
    deplacerCurseurXY(30,20);write('Payer 500 d''or');
    deplacerCurseurXY(30,21);write('Faire 3 entrainements');

    deplacerCurseurXY(30,23);write('Il vous propose ensuite un secret qui vous permettra de plus d''objet que d''habitude.');

    deplacerCurseurXY(30,25);write('La competence s''appelle louteur et pour la maitriser completement vous devez :');
    deplacerCurseurXY(30,26);write('Payer 750 d''or');
    deplacerCurseurXY(30,27);write('Faire 5 entrainements');

    couleurTexte(White);
    deplacerCurseurZoneAction(1);write('Que souhaitez-vous faire ?');
    deplacerCurseurZoneAction(3);write('     1/ Gros degats');
    deplacerCurseurZoneAction(4);write('     2/ Bouclier');
    deplacerCurseurZoneAction(5);write('     3/ Louteur');
    deplacerCurseurZoneAction(6);write('     4/ Sortir du camp d''entrainement');

    deplacerCurseurZoneResponse();
    readln(choix);
  end;
  case choix of
       '1' : campHub := grosDegats();
       '2' : campHub := bouclier();
       '3' : campHub := louteur();
       '4' : campHub := ville;
  end;

end;

function grosDegats() : typeLieu;
begin
     effacerEcran;
     deg := false;
     if (perso.argent - 600 < 0 )then
        begin
        deplacerCurseurXY(30,17);
        write('vous ne pouvez pas acquerir cette competence')
        end
     else
     begin
       if (i = 0) then
          perso.argent:= perso.argent-600;
       if i<3 then
          begin
          i:=i+1;
          deplacerCurseurXY(30,17);
          write('il vous reste ',4-i,' entrainement');
          end
       else
       begin
         deplacerCurseurXY(30,17); write('vous avez acquis la competence');
         deg := true;
       end;

     end;
     readln;
     grosDegats:=campHub;

end;

function bouclier():typeLieu;
begin
  effacerEcran();
  bouc := false;
     if perso.argent - 500 < 0 then
        begin
        deplacerCurseurXY(30,17);
        write('vous ne pouvez pas acquerir cette competence');
        end
     else
     begin
       if (j = 0) then
          perso.argent:= perso.argent-500;
     if j<2 then
        begin
        j:=j+1;
        deplacerCurseurXY(30,17);
        write('il vous reste ',3-j,' entrainement');
        end
     else
       begin
       pos.x:=30;
       pos.y:=17;
       ecrireEnPosition(pos, 'vous avez acquis la competence');
       bouc := true;
       end;
     end;
     readln;
     bouclier:=campHub;
end;

function louteur():typeLieu;
begin
  effacerEcran();
  lout := false;
     if perso.argent - 750 < 0 then
        begin
        deplacerCurseurXY(30,17);
        write('vous ne pouvez pas acquerir cette competence');
        end
     else
     begin
     if (k = 0) then
          perso.argent:= perso.argent-750;
     if k<4 then
        begin
        k:=k+1;
        deplacerCurseurXY(30,17);
        write('il vous reste ',5-k,' entrainement');
        end
     else
       begin
       deplacerCurseurXY(30,17); write('vous avez acquis la competence');
       lout := true;
       end;
     end;
     readln;
     louteur:=campHub;
end;



end.

