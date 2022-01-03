unit menu;

{$mode objfpc}{$H+}

interface

function menuPrincipal(): integer;
procedure menuQuitter();
procedure menuHistoire();
procedure menuPerso();
procedure menuLauncher();
function menuJeu(): integer;
function menuForge():integer;
procedure menuNoSave();

implementation

uses
  Classes, SysUtils, GestionEcran, logique, personnage, controle, outils, uniteforge;

// cette fonction affiche le menu principal et demande a l'utilisateur de choisir ce qu'il veut faire
function menuPrincipal(): integer;

var

  ch: char;
  select: integer;
  pos: coordonnees;

begin

  effacerEcran();
  ascii('start', 0, 0);
  couleurs(0, 15);
  pos.x := 54;
  pos.y := 20;
  ecrireEnPosition(pos, 'Nouvelle partie');
  couleurs(15, 0);
  pos.x := 54;
  pos.y := 22;
  ecrireEnPosition(pos, 'Charger partie');
  pos.x := 54;
  pos.y := 24;
  ecrireEnPosition(pos, 'Histoire du jeu');
  pos.x := 54;
  pos.y := 26;
  ecrireEnPosition(pos, 'Quitter');
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  deplacerCurseurXY(0, 0);
  select := 1;

  repeat

    ch := ReadKey;

    case ch of
      'P':
      begin
        select := select + 1;
        if (select >= 5) then
          select := 1;
      end;
      'H':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 4;
      end;
    end;

    case select of
      1:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        deplacerCurseurXY(0, 0);
      end;
      3:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        deplacerCurseurXY(0, 0);
      end;
      4:
      begin
        couleurs(0, 15);
        pos.x := 54;
        pos.y := 26;
        ecrireEnPosition(pos, 'Quitter');
        couleurs(15, 0);
        pos.x := 54;
        pos.y := 20;
        ecrireEnPosition(pos, 'Nouvelle partie');
        pos.x := 54;
        pos.y := 22;
        ecrireEnPosition(pos, 'Charger partie');
        pos.x := 54;
        pos.y := 24;
        ecrireEnPosition(pos, 'Histoire du jeu');
        deplacerCurseurXY(0, 0);
      end;
    end;
  until ch = #13;

  menuPrincipal := select;

end;

// cette procedure lance la personalisation du perso
procedure menuPerso();

var

  nom: string;
  taille: string;
  poids: string;
  pos: coordonnees;
  b: boolean;
  select: integer;
  ch: char;

begin

  effacerEcran();
  ascii('personnage', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour valider');
  pos.x := 13;
  pos.y := 3;
  ecrireEnPosition(pos, 'Entrer votre pseudo : ');
  readln(nom);
  setPseudo(nom);
  pos.x := 13;
  pos.y := 5;
  ecrireEnPosition(pos, 'Entrer votre taille(cm) : ');
  readln(taille);

  b := False;

  repeat
    try
      setTaille(StrToInt(taille));
      b := True;
    except
      on Exception: EConvertError do
      begin

        couleurs(4, 0);
        pos.x := 13;
        pos.y := 9;
        ecrireEnPosition(pos,
          'Veuillez mettre uniquement des chiffres               ');
        couleurs(15, 0);
        pos.x := 13;
        pos.y := 5;
        ecrireEnPosition(pos,
          'Entrer votre taille(cm) :                             ');
        ecrireEnPosition(pos, 'Entrer votre taille(cm) : ');
        readln(taille);

      end;

    end;
  until b;

  pos.x := 13;
  pos.y := 7;
  ecrireEnPosition(pos, 'Entrer votre poid(kg) : ');
  readln(poids);

  b := False;

  repeat
    try

      setPoid(StrToInt(poids));
      b := True;

    except
      on Exception: EConvertError do
      begin

        couleurs(4, 0);
        pos.x := 13;
        pos.y := 9;
        ecrireEnPosition(pos,
          'Veuillez mettre uniquement des chiffres               ');
        couleurs(15, 0);
        pos.x := 13;
        pos.y := 7;
        ecrireEnPosition(pos,
          'Entrer votre poid(kg) :                               ');
        ecrireEnPosition(pos, 'Entrer votre poid(kg) : ');
        readln(poids);

      end;
    end;
  until b;

  ascii('boy', 89, 3);
  pos.x := 13;
  pos.y := 9;
  ecrireEnPosition(pos, 'Pour change le personnage(les fleches directionnelle)');
  deplacerCurseurXY(0, 0);

  select := 1;

  repeat

    ch := ReadKey;

    case ch of
      'M':
      begin
        select := select + 1;
        if (select >= 3) then
          select := 1;
      end;
      'K':
      begin
        select := select - 1;
        if (select <= 0) then
          select := 2;
      end;
    end;

    case select of
      1:
      begin
        ascii('boy', 89, 3);
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        ascii('girl', 89, 3);
        deplacerCurseurXY(0, 0);
      end;
    end;

  until ch = #13;

  if (select = 1) then
    setSexe(m)
  else
    setSexe(f)
  ;

  menuLauncher();

end;

// cette procedure afiiche les caracteristiques du perso et lui demande si il veut entrer dans la ville
procedure menuLauncher();

var

  pos: coordonnees;
  ch: char;
  select: integer;

begin

  effacerEcran();
  ascii('personnage2', 0, 0);

  if (getSexe() = m) then
    ascii('boy', 1, 2)
  else
    ascii('girl', 1, 2)
  ;

  pos.x := 30;
  pos.y := 1;
  ecrireEnPosition(pos, concat('Votre sexe : ', getSexeString()));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Pseudo : ', getPseudo()));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Taille : ', IntToStr(getTaille()), ' cm'));
  pos.x := 30;
  pos.y := pos.y + 1;
  ecrireEnPosition(pos, concat('Votre Poid : ', IntToStr(getPoid()), ' kg'));
  pos.x := 30;
  pos.y := 19;
  ecrireEnPosition(pos, 'Etes-vous sur de vos choix');
  pos.x := 30;
  pos.y := 21;
  ecrireEnPosition(pos, 'Oui');
  couleurs(0, 15);
  pos.x := 35;
  pos.y := 21;
  ecrireEnPosition(pos, 'Non');
  couleurs(15, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  deplacerCurseurXY(0, 0);

  select := 1;

  repeat

    ch := ReadKey;

    case ch of
      'M':
      begin
        select := select + 1;
        if (select >= 3) then
          select := 1;
      end;
      'K':
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
        pos.x := 35;
        pos.y := 21;
        ecrireEnPosition(pos, 'Non');
        couleurs(15, 0);
        pos.x := 30;
        pos.y := 21;
        ecrireEnPosition(pos, 'Oui');
        deplacerCurseurXY(0, 0);
      end;
      2:
      begin
        couleurs(0, 15);
        pos.x := 30;
        pos.y := 21;
        ecrireEnPosition(pos, 'Oui');
        couleurs(15, 0);
        pos.x := 35;
        pos.y := 21;
        ecrireEnPosition(pos, 'Non');
        deplacerCurseurXY(0, 0);
      end;
    end;

  until ch = #13;

  if (select = 1) then
    menuPerso()
  else
    pieces()
  ;

end;

// cette procedure affiche le prelude du jeu
procedure menuHistoire();

var

  ch: char;
  pos: coordonnees;

begin

  effacerEcran();
  ascii('prelude', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour revenir au menu principale');
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;

end;

// cette procedure permet de quitter
procedure menuQuitter();

var

  ch : char;

begin

  effacerEcran();
  ascii('byebye',0,0);
  deplacerCurseurXY(0, 0);

  repeat
    ch := ReadKey;
  until ch = #13;

end;

// cette fonction nous permet de lancer la ville
function menuJeu(): integer;

var

  ch: char;
  select : Integer;
  pos: coordonnees; 
  pos2: coordonnees;
  b : boolean;

begin

  effacerEcran();
  b := false;
  couleurs(15, 0);
  ascii('village', 0, 0);
  pos.x := 1;
  pos.y := 28;
  ecrireEnPosition(pos, 'appuyer sur entrer pour selectionner');
  pos.x := 46;
  pos.y := 14;
  deplacerCurseurXY(pos.x, pos.y);
  couleurs(3, 0);
  write(char(219),char(219));
  couleurs(15, 0);

  select := 1;

  repeat

    ch := ReadKey;

    case ch of
      #13:
       begin

           if ((select = 1) or (select = 5)) then
               begin

                   couleurs(4, 0);
                   pos2.x := 77;
                   pos2.y := 28;
                   ecrireEnPosition(pos2, 'Veuillez selectionner un emplacement valide');
                   couleurs(15,0);

               end
           else
               b := true
           ;
           deplacerCurseurXY(0, 0);

       end;
      'P':
       begin

           pos2.x := 77;
           pos2.y := 28;
           ecrireEnPosition(pos2, '                                           ');

           case select of
               1:
                begin

                    select := 3;
                    animationdeplacement(pos.x, pos.y, 0, 2);
                    pos.y := pos.y + 4;

                end;
               4:
                begin

                    select := 1;
                    animationdeplacement(pos.x, pos.y, 0, 2);
                    pos.y := pos.y + 4;
                end;
               6:
                begin

                    select := 5;
                    animationdeplacement(pos.x, pos.y, 0, 2);
                    pos.y := pos.y + 4;
                end;
               5:
                begin

                    select := 8;
                    animationdeplacement(pos.x, pos.y, 0, 2);
                    pos.y := pos.y + 4;

                end;
           end;

           deplacerCurseurXY(0, 0);
      end;

      'H':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 4;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             3:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             5:
             begin
             select := 6;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
             8:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, 0, -2);
             pos.y := pos.y - 4;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;
      'M':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, 16, 0);
             pos.x := pos.x + 32;
             end;
             2:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, 11, 0);
             pos.x := pos.x + 22;
             end;
             5:
             begin
             select := 7;
             animationdeplacement(pos.x, pos.y, 6, 0);
             pos.x := pos.x + 12;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;
      'K':
      begin
        pos2.x := 77;
        pos2.y := 28;
        ecrireEnPosition(pos2, '                                           ');
        case select of
             1:
             begin
             select := 2;
             animationdeplacement(pos.x, pos.y, -11, 0);
             pos.x := pos.x - 22;
             end;
             5:
             begin
             select := 1;
             animationdeplacement(pos.x, pos.y, -16, 0);
             pos.x := pos.x + -32;
             end;
             7:
             begin
             select := 5;
             animationdeplacement(pos.x, pos.y, -6, 0);
             pos.x := pos.x - 12;
             end;
        end;
        deplacerCurseurXY(0, 0);
      end;

    end;
  until ((ch = #13) and (b = true));
  couleurs(15, 0);
  menuJeu := select;
end;

//cette fonction permet de lancer la forge
function menuForge():integer;

var

  select:Integer;
  inv,posinv,posinv2:TypeInventaire;
  max:Integer;
  it : Item;
  countmax:Integer;
  i,j:Integer;
  item1,item2:Item;
  itemResult:Item;
  ch : char;
  stop : boolean;
  pos: coordonnees;

begin

  effacerEcran;
  couleurs(15, 0);
  ascii('forge', 0, 0);
  pos.x:=60;
  pos.y:=2;
  ecrireEnPosition(pos, 'Choisir le 1er item ');
  pos.x:=3;
  pos.y:=1;
  ecrireEnPosition(pos, 'Aide creation : ');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Epee = 2 (Bois/Fer/Aeter) + 1 (Bois)');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Casque = 5 (Cuir/Fer/Aeter)');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Torse = 8 (Cuir/Fer/Aeter)');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Jambieres = 7 (Cuir/Fer/Aeter)');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Bottes = 4 (Cuir/Fer/Aeter)');
  pos.y:=pos.y+1;
  ecrireEnPosition(pos, 'Gants= 2 (Cuir/Fer/Aeter)');

  pos.x := 58;
  pos.y := 6;

  stop := false;
  select := 1;
  countmax := 0;
  inv := getInventory();

  for i := Low(inv) to High(inv) do
    begin

      it := getItemInventory(i);

      if ((it.id > 0)) then
        begin

           countmax := countmax + 1;
           posinv[countmax] := it;

           if ((select = countmax)) then
               couleurs(0, 15)
           else
               couleurs(15, 0)
           ;

           if (tabProduits[tabIdProduits[it.id]].id = it.id) then
               ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));

           pos.y := 6 + countmax;

        end;
      end;

  couleurs(15, 0);
  pos.x := 58;
  pos.y := 27;
  ecrireEnPosition(pos, 'Menu');
  deplacerCurseurXY(0, 0);

  countmax := 0;

  repeat

    ch := ReadKey;

    case ch of
      'P':
       begin

           select := select + 1;
           if (select > countmax + 1) then
               select := 1;
       end;
      'H':
       begin
           select := select - 1;
           if (select <= 0) then
               select := countmax + 1;
       end;
    end;

    pos.x := 58;
    pos.y := 6;
    countmax := 0;
    inv := getInventory();

    for i := Low(inv) to High(inv) do
        begin

           it := getItemInventory(i);

           if ((it.id > 0)) then
               begin

                   countmax := countmax + 1;
                   posinv[countmax] := it;
                   if ((select = countmax)) then
                       couleurs(0, 15)
                   else
                       couleurs(15, 0)
                   ;

                   if (tabProduits[tabIdProduits[it.id]].id = it.id) then
                       ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));

                   pos.y := 6 + countmax;
                end;
        end;

  couleurs(15, 0);
  pos.x := 71;
  pos.y := 2;
  if (select = countmax + 1) then
      begin

          couleurs(0, 15);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')

      end
    else
      begin

          couleurs(15, 0);

          pos.x := 58;
          pos.y := 27;
          ecrireEnPosition(pos, 'Menu')
      end;
    ;

    couleurs(15, 0);
    deplacerCurseurXY(0, 0);

  until ch = #13;

  if (select = countmax + 1) then
    stop := true
  ;

  if (stop = false) then
    begin

        item1 := posinv[select];
        max:=posinv[select].count;
        pos.x:=58;
        pos.y:=26;
        ecrireEnPosition(pos, 'Quelle quantite de cet item voulez vous ');
        pos.x:=58;
        pos.y:=27;
        ecrireEnPosition(pos, 'prendre afin de forger un nouvel equipement ?');
        pos.x:=58;
        pos.y:=28;
        ecrireEnPosition(pos, '(Vous pouvez rentrer 0) : ');
        readln(j);
        item1.count:=j;

        pos.x:=58;
        pos.y:=26;
        ecrireEnPosition(pos, '                                        ');
        pos.x:=58;
        pos.y:=27;
        ecrireEnPosition(pos, '                                             ');
        pos.x:=58;
        pos.y:=28;
        ecrireEnPosition(pos, '                               ');

        if (select = countmax + 1) then
             begin

                couleurs(0, 15);

                pos.x := 58;
                pos.y := 27;
                ecrireEnPosition(pos, 'Menu')
             end
        else
             begin

                couleurs(15, 0);

                pos.x := 58;
                pos.y := 27;
                ecrireEnPosition(pos, 'Menu')
              end
        ;

        pos.x:=60;
        pos.y:=2;
        ecrireEnPosition(pos, 'Choisir le 2eme item ');
        deplacerCurseurXY(0, 0);

        repeat

            ch := ReadKey;

            case ch of
              'P':
               begin

                   select := select + 1;

                   if (select > countmax + 1) then
                       select := 1;
               end;
              'H':
               begin

                   select := select - 1;

                   if (select <= 0) then
                       select := countmax + 1
                   ;
               end;

            end;

            pos.x := 58;
            pos.y := 6;
            countmax := 0;
            inv := getInventory();

            for i := Low(inv) to High(inv) do
                begin

                    it := getItemInventory(i);

                    if ((it.id > 0)) then
                      begin

                          countmax := countmax + 1;
                          posinv2[countmax] := it;

                           if ((select = countmax)) then
                               couleurs(0, 15)
                           else
                               couleurs(15, 0)
                           ;

                           if (tabProduits[tabIdProduits[it.id]].id = it.id) then
                               ecrireEnPosition(pos, concat(InttoStr(countmax) , ' ',tabProduits[tabIdProduits[it.id]].nom, ' x', InttoStr(it.count)));

                           pos.y := 6 + countmax;
                      end;
                 end;

            couleurs(15, 0);
            pos.x := 71;
            pos.y := 2;

            if (select = countmax + 1) then
              begin

                  couleurs(0, 15);

                  pos.x := 58;
                  pos.y := 27;
                  ecrireEnPosition(pos, 'Menu');

              end
            else
              begin

                  couleurs(15, 0);

                  pos.x := 58;
                  pos.y := 27;
                  ecrireEnPosition(pos, 'Menu')
              end
            ;

            couleurs(15, 0);
            deplacerCurseurXY(0, 0);
        until ch = #13;

        if (select = countmax + 1) then
          stop := true
        ;

        if (stop = false) then
          begin

              item2:=posinv2[select];

              pos.x:=58;
              pos.y:=26;
              ecrireEnPosition(pos, 'Quelle quantite de cet item voulez vous ');
              pos.x:=58;
              pos.y:=27;
              ecrireEnPosition(pos, 'prendre afin de forger un nouvel equipement ?');
              pos.x:=58;
              pos.y:=28;
              ecrireEnPosition(pos, '(Vous pouvez rentrer 0) : ');
              readln(j);

              pos.x:=58;
              pos.y:=26;
              ecrireEnPosition(pos, '                                        ');
              pos.x:=58;
              pos.y:=27;
              ecrireEnPosition(pos, '                                             ');
              pos.x:=58;
              pos.y:=28;
              ecrireEnPosition(pos, '                               ');
              item2.count:=j;

              if (select = countmax + 1) then
                begin

                    couleurs(0, 15);

                    pos.x := 58;
                    pos.y := 27;
                    ecrireEnPosition(pos, 'Menu')

                end
              else
                begin

                    couleurs(15, 0);

                    pos.x := 58;
                    pos.y := 27;
                    ecrireEnPosition(pos, 'Menu')

              end
          ;

          deplacerCurseurXY(0, 0);
          pos.x := 1;
          pos.y := 28;
          ecrireEnPosition(pos, 'appuyer sur entrer pour valider');

          if (item1.id=item2.id) and (max<item1.count+item2.count) then
            begin

                pos.x:=58;
                pos.y:=27;
                ecrireEnPosition(pos, 'Vous n''avez pas assez');
                menuForge := 2;

            end
          else
            begin

                itemResult:=getCraftResult(item1,item2);

                if itemResult.id<>0 then
                    begin

                        pos.x:=58;
                        pos.y:=27;
                        ecrireEnPosition(pos, Concat('Vous avez cree un ', tabEquipments[tabIdEquipments[itemResult.id]].nom));
                        addItemInventory(itemResult);
                        removeItemInventory(item1.id,item1.count);
                        removeItemInventory(item2.id,item2.count);

                        menuForge := 2;

                    end
                 else
                    begin

                        pos.x:=58;
                        pos.y:=27;
                        ecrireEnPosition(pos,'Aucun item n''a ce craft');
                        menuForge := 2;
                    end
                 ;

                 repeat
                     ch := ReadKey;
                 until ch = #13;
              end
           end
        else
          menuForge := 1
        ;
      end
  else
    menuForge := 1
  ;

end;

// cette procedure affiche que le joueur n'as pas de partie sauvgarder
procedure menuNoSave();

var

  ch : Char;

begin

  effacerEcran;
  couleurs(15,0);
  ascii('nosave',0,0);
  deplacerCurseurXY(0,0);

  repeat
    ch := ReadKey;
  until ch = #13;

end;

end.
