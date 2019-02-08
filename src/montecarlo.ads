with utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;
use utils,  ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO;

package montecarlo is
   
   SAMPLE_SIZE : constant Integer := 10000;
   type T_Sample is Array(0..SAMPLE_SIZE-1) of T_set;
   
   --Initialise un echantillon de taille SAMPLE_SIZE, avec deux aleatoires dans chaque enssemble de l'echantillon
   procedure initSample(sample : in out T_Sample;  cards : in T_set);
   
   --Calcule les chances de gagner avec une combinaison en particulier
   function chancesOfWinning(sample : in T_Sample; best : in T_combination) return float;
   
   --Ajoute n cartes a partir de l'indice index a un echantillon
   procedure addToSampleSets(sample : in out T_Sample; card : T_card);
      
private
   --Renvoie une carte aleatoire
   function randomCard(max : in Integer) return T_card;
   --Verifie qu'un enssemble contiens une carte en particulier
   function cardInSet(card : in T_card; set : in T_set) return Boolean;
     
end montecarlo;
