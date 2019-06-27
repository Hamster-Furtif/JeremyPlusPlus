with utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;
use utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;

package montecarlo is
   
   SAMPLE_SIZE : constant Integer := 10000;
   type T_Sample is Array(0..SAMPLE_SIZE-1) of T_set;
   --E/ cards : T_set
   --E/S/ sample : T_sample
   --Necessite : None
   --Entraine : Initialise un echantillon avec SAMPLE_SIZE elements, chacun compose de deux cartes aleatoires. 
   --           Represente l'ensemble des mains contre lesquelles on va jouer dans Monte Carlo
   function initSample(sample : in out T_Set; hand : in T_set; table : in T_set) return Integer;
   
   --E/ sample : T_sample
   --E/ best : T_combinaison
   --Necessite : None
   --S/ chance de gain : float
   --Entraine : Calcule la porbabilte de gagner avec une combinaison en particulier
   function chancesOfWinning(hand : T_set; table : T_set) return float;
   
   --E/S/ sample : T_sample
   --E/ card : T_card
   --Necessite : None
   --Entraine : Ajoute une même carte a toutes les mains de l'echantillon
    procedure addToSampleSets(sample : in out T_Sample; card : T_card);
      

   --E/ max : integer
   --Necessite : none
   --S/ card : T_carte
   --Entraine : Renvoie une carte aleatoire
   function randomCard(max : in Integer) return T_card;
   private
   --E/ card : T_card
   --E/ set : T_set
   --Necessite : None
   --S/ : Boolean
   --Entraine   :Verifie qu'un ensemble contient une carte en particulier
   function cardInSet(card : in T_card; set : in T_set) return Boolean;
end montecarlo;
