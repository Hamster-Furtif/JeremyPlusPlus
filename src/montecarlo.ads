with utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;
use utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;

package montecarlo is
   
   --E/ cards : T_set
   --E/S/ sample : T_set
   --Necessite : Table ne contient pas plus de 5 cartes
   --Entraine : Genere 50 000 jeux en completant le jeu existant (donne par
   --            la main et les cartes communes revelees) avec des cartes aleatoires
   function initSample(sample : in out T_Set; hand : in T_set; table : in T_set) return Integer;
   
   --E/ hand, table : T_set
   --Necessite : hand contient 2 cartes et table contient 1 a 4 cartes
   --S/ chance de gain : float
   --Entraine : Calcule la porbabilte de gagner avec la methode de Monte Carlo
   function chancesOfWinning(hand : T_set; table : T_set) return float;
   
     
   
   --E/ max : integer
   --Necessite : none
   --S/ card : T_carte
   --Entraine : Renvoie une carte aleatoire
   function randomCard(max : in Integer) return T_card;
   
end montecarlo;
