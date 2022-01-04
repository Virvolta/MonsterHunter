//Unit en charge de la gestion du personnage
unit unitpersonnage;
{$codepage utf8}
{$mode objfpc}{$H+}

interface
uses
    unitObjet,unitEquipement;
//----- TYPES -----
type
  bonus = (AucunB,Force,Regeneration);       //Bonus de la cantinue
  genre = (Masculin,Feminin,Autre);          //Genre du personnage

  //Type représentant le personnage
  Personnage = record
    nom : String;                           //Nom du personnage
    sexe : genre;                           //Genre du personnage
    taille : integer;                       //taille du personnage
    inventaire : Tinventaire;               //Inventaire
    parties : TinventairePartie;            //Inventaire des parties de monstres
    arme : materiaux;                       //Arme utilisée
    armures : TArmures;                     //Armures
    sante : integer;                        //Vie du personnage
    santemax : integer;                      //Vie max du personnage
    argent : integer;                       //Argent du personnage
    buff : bonus;                           //Buff du joueur
    Xp : integer                            //Xp du joueur
  end;

  //Type représentant un coffre d'équipement
  TCoffre = record
    armures : TCoffreArmures;               //Armures présentes dans le coffre
    armes : TCoffreArmes;                   //Armes présentes dans le coffre
  end;

   
//----- FONCTIONS ET PROCEDURES -----  
//Initialisation du joueur
procedure initialisationJoueur(); 
//Initialisation du coffre de la chambre
procedure initialisationCoffre();
//Renvoie le personnage (lecture seul)
function getPersonnage() : Personnage;
//Renvoie le coffre (lecture seul)
function getCoffre() : TCoffre;
//Transforme un Genre en chaine de caractères
function genreToString(sexe : genre) : string;
//Change le nom du joueur
procedure setNomPersonnage(nom : string);
//Change la taille du joueur
procedure setTaillePersonnage(taille : integer);  
//Change le genre du joueur
procedure setGenrePersonnage(sexe : genre);
//Ajoute (ou retire) une quantité QTE de l'objet ID dans l'inventaire du joueur
procedure ajoutObjet(id : integer; qte : integer);    
//Dormir dans son lit
procedure dormir(); 
//Change l'arme du joueur
procedure changerArme(mat : integer); 
//Change l'armure du joueur
procedure changerArmure(slot,mat : integer); 
//Achete un objet du type i
procedure acheterObjet(i : integer);  
//Vendre un objet du type i
procedure vendreObjet(i : integer); 
//Renvoie le montant de dégats d'une attaque
function degatsAttaque() : integer;  
//Renvoie le montant de dégats recu
function degatsRecu() : integer; 
//Ajoute une partie de monstre
procedure ajouterPartie(i : integer); 
//Soigne le personnage de 50pv
procedure soigner();        
//Soigne le personnage de 1pv
procedure regen();
//Supprime 1 objet
procedure utiliserObjet(i : integer); 
//Récupère une prime pour avoir tué un monstre
procedure recupererPrime(qte : integer); 
//Renvoie si le joueur possède les ingrédients (et l'or) pour crafter l'objet
function peuxForger(mat : materiaux) : boolean;
//Forge une arme du matériaux donné
procedure forgerArme(mat : materiaux);
//Forge une armure du matériaux donné
procedure forgerArmure(slot : integer; mat : materiaux); 
//Converti un bonus en chaine de caractères
function bonusToString(buff : bonus) : String;
//Change le buff du joueur
procedure setBuff(buff : bonus);
//Recuperer l'XP du joueur
function getXp() : Integer;
//Definir l'XP du joueur
procedure setXP(x : Integer);
//Ajouter de l'XP au joueur
procedure addXp(x : Integer);
//Enlenver de l'XP au joueur
procedure delXp(x : Integer);
//Connaitre l'XP du joueur
function hasXp(x : Integer) : boolean;
//Permet de connaitre le niveau de joueur
function getLevel() : integer;
//Permet d'ajouter des recompense au joueur
procedure addLevelGift(preclevel, nextlevel : Integer);
function sqrt(x:real):real;
function getMinXpInLevel(level :integer) : integer;
function getMaxXpInLevel(level :integer) : integer;







 var
   perso : Personnage;                      //Le personnage



implementation
uses
    unitMonstre;
var
  coffre : TCoffre;                        //Le coffre de la chambre

   
//Initialisation du coffre de la chambre
procedure initialisationCoffre();
var
   mat,slot : integer;
begin
  //Armures (vide)
  for slot:=0 to 4 do
    for mat:=1 to ord(high(materiaux)) do
      coffre.armures[slot,mat] := false;
  //Armes (vide)
  for mat:=1 to ord(high(materiaux)) do
    coffre.armes[mat] := false;

  //Ajoute une épée de fer
  coffre.armes[1] := true;

end;

//Initialisation du joueur
procedure initialisationJoueur();
var
   i:integer;
begin
  //Inventaire vide
  for i:=1 to nbObjets do perso.inventaire[i] := 0;
  //Inventaire de partie vide
  for i := 0 to ord(high(TypeMonstre)) do perso.parties[i] := 0;
  //En pleine forme
  perso.sante:=100;
  perso.santemax:=100;
  //Pas d'arme
  perso.arme := aucun;
  //Pas d'armure
  for i := 0 to 4 do perso.armures[i] := aucun; 
  //Ajouter 200 PO
  perso.argent:=200;
  //Xp
  addXp(10);
end;

//Renvoie le personnage (lecture seul)
function getPersonnage() : Personnage;
begin
  getPersonnage := perso;
end;

//Renvoie le coffre (lecture seul)
function getCoffre() : TCoffre;
begin
  getCoffre := coffre;
end;

//Transforme un Genre en chaine de caractères
function genreToString(sexe : genre) : string;
begin
  case sexe of
       Masculin : genreToString := 'Masculin';
       Feminin : genreToString := 'Féminin';
       Autre : genreToString := 'Autre';
  end;
end;

//Change le nom du joueur
procedure setNomPersonnage(nom : string);
begin
  perso.nom:=nom;
end;

//Change le genre du joueur
procedure setGenrePersonnage(sexe : genre);
begin
  perso.sexe:=sexe;
end;

//Change la taille du joueur
procedure setTaillePersonnage(taille : integer);
begin
  perso.taille:=taille;
end;

//Ajoute (ou retire) une quantité QTE de l'objet ID dans l'inventaire du joueur
procedure ajoutObjet(id : integer; qte : integer);
begin
     perso.inventaire[id] += qte;
     if(perso.inventaire[id] < 0) then perso.inventaire[id] := 0;
end;

//Dormir dans son lit
procedure dormir();
begin
  perso.sante:=perso.santemax;
end;

//Change l'arme du joueur
procedure changerArme(mat : integer);
begin
  //Enlève l'arme du coffre
  coffre.armes[mat] := false;
  //Range l'arme dans le coffre (si le joueur en a une)
  if(ord(perso.arme) <> 0) then coffre.armes[ord(perso.arme)] := true;
  //Equipe la nouvelle arme
  perso.arme := materiaux(mat);
end;


//Change l'armure du joueur
procedure changerArmure(slot,mat : integer);
begin
  //Enlève l'armure du coffre
  coffre.armures[slot,mat] := false;
  //Range l'armure dans le coffre (si le joueur en a une)
  if(ord(perso.armures[slot]) <> 0) then coffre.armures[slot,ord(perso.armures[slot])] := true;
  //Equipe la nouvelle armure
  perso.armures[slot] := materiaux(mat);
end;

//Achete un objet du type i
procedure acheterObjet(i : integer);
begin
  perso.argent -= getObjet(i).prixAchat;
  perso.inventaire[i] += 1;
end;

//Vendre un objet du type i
procedure vendreObjet(i : integer);
begin
  perso.argent += getObjet(i).prixVente;
  perso.inventaire[i] -= 1;
end;

//Renvoie le montant de dégats d'une attaque
function degatsAttaque() : integer;
begin
  degatsAttaque := (4+Random(5))*multiplicateurDegatsArme(perso.arme);
end;

//Renvoie le montant de dégats recu
function degatsRecu() : integer;
begin
  degatsRecu := (2+Random(10))-encaissement(perso.armures);
  perso.sante -= degatsRecu;
  if perso.sante < 0 then perso.sante := 0;
end;

//Ajoute une partie de monstre
procedure ajouterPartie(i : integer);
begin
  perso.parties[i] += 1;
end;

//Soigne le personnage de 50pv
procedure soigner();
begin
  perso.sante += 50;
  if(perso.sante > 100) then perso.sante := 100;
end;

//Soigne le personnage de 1pv
procedure regen();
begin
  perso.sante += 1;
  if(perso.sante > 100) then perso.sante := 100;
end;

//Supprime 1 objet
procedure utiliserObjet(i : integer);
begin
  perso.inventaire[i] -= 1;
end;

//Récupère une prime pour avoir tué un monstre
procedure recupererPrime(qte : integer);
begin
  perso.argent += qte;
end;

//Renvoie si le joueur possède les ingrédients (et l'or) pour crafter l'objet
function peuxForger(mat : materiaux) : boolean;
begin
     //Test de l'argent
     peuxForger := (perso.argent >= 500);
     //Test des matériaux et de l'XP
     case mat of
          os : peuxForger := peuxForger AND (perso.parties[0]>4) AND hasXp(160);
          Ecaille : peuxForger := peuxForger AND (perso.parties[1]>4) AND hasXp(640);
     end;

end;

//Forge une arme du matériaux donné
procedure forgerArme(mat : materiaux);
begin
     //retire l'or
     perso.argent -= 500;
     
     //Retire les matériaux
     case mat of
          os : perso.parties[0] -= 5;
          Ecaille : perso.parties[1] -= 5;
     end;

     //Ajoute l'arme dans le coffre
     coffre.armes[ord(mat)] := true;
end;

//Forge une armure du matériaux donné
procedure forgerArmure(slot : integer; mat : materiaux);
begin
     //retire l'or
     perso.argent -= 500;

     //Retire les matériaux
     case mat of
          os : perso.parties[0] -= 5;
          Ecaille : perso.parties[1] -= 5;
     end;

     //Ajoute l'armure dans le coffre
     coffre.armures[slot,ord(mat)] := true;
end;

//Converti un bonus en chaine de caractères
function bonusToString(buff : bonus) : String;
begin
  case buff of
       AucunB:bonusToString:='Aucun';
       Force:bonusToString:='Force';
       Regeneration:bonusToString:='Regénération';
  end;
end;

//Change le buff du joueur
procedure setBuff(buff : bonus);
begin
  perso.buff := buff;
end;

//Recuperer l'XP du joueur
function getXp() : Integer;

begin

  getXp := perso.Xp;

end;

// cette procedure permet de definire de force combient d'Xp à le joueur
procedure setXp(x : Integer);

begin

  perso.Xp := x;

end;

// cette procedure permet d'ajouter de l'Xp au joueur
procedure addXp(x : Integer);

var
   preclevel : Integer;
   nextlevel : Integer;

begin
  preclevel := getLevel();
  perso.Xp := perso.Xp + x;
  nextlevel := getLevel();

  if (preclevel < nextlevel) then
     addLevelGift(preclevel, nextlevel);
end;

// cette procedure permet de supprimer de l'Xp au joueur
procedure delXp(x : Integer);

var
   preclevel : Integer;
   nextlevel : Integer;

begin
  preclevel := getLevel();
  perso.Xp := perso.Xp - x;
  nextlevel := getLevel();

  if (preclevel > nextlevel) then
     perso.Xp := getMinXpInLevel(preclevel);

end;

// cette fonction permet de verifier si le joueur a l'Xp disponible pour forger
function hasXp(x : Integer) : boolean;

begin

  if (perso.Xp - x >= 0) then
    hasXp := true
  else
    hasXp := false;

end;


procedure addLevelGift(preclevel, nextlevel : Integer);
var
   i : Integer;
begin
  for i := preclevel + 1 to nextlevel do
    begin
      case i of
           2:
           begin
             perso.santemax := perso.santemax + 10;
           end;
           3:
           begin
             perso.argent := perso.argent + 20;
           end;
           4:
           begin
             perso.inventaire[1] += 1;
           end;
           5:
           begin
             perso.argent := perso.argent + 100;
           end;
           6:
           begin
             perso.sante := perso.sante + 50;
           end;
           7:
           begin
             perso.argent := perso.argent + 30;
           end;
           8:
           begin
             perso.inventaire[2] += 1;
           end;
           9:
           begin
             perso.argent := perso.argent + 200;
           end;
      end;
    end;
end;

function sqrt(x:real):real;
var
 a,b,m,xn:Real;
begin
 if x = 0.0 then
    begin
        sqrt := 0.0;
    end
 else
    begin
        m := 1.0;
        xn := x;
        while xn >= 2.0 do
            begin
                xn := 0.25 * xn;
                m:=2.0 * m;
            end;
        while xn < 0.5 do
            begin
                xn := 4.0 * xn;
                m := 0.5*m;
            end;
        a := xn;
        b := 1.0-xn;

        repeat
            a := a * (1.0+0.5*b);
            b := 0.25 * (3.0+b) * b * b;
        Until b < 1.0E-15;
        sqrt := a * m;
    end;
End;

const
  palier = 10;

function getLevel() : integer;
begin
  getLevel := round((sqrt(getXP)) / (sqrt(palier)));
end;

function getMinXpInLevel(level :integer) : integer;
begin
  getMinXpInLevel := (level * level) * palier;
end;

function getMaxXpInLevel(level :integer) : integer;
begin
  getMaxXpInLevel := ((level - 1 * level - 1) * palier) ;
end;



end.

