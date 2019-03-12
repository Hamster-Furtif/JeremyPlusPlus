with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;


package Mastermind is

   
   
   -- /E: game : T_game
   -- /E: logic : T_logic
   --/Nécessite : tous les numeriques du t_logic >=0
   --/S : string
   -- Entraine : donne le message a retouner au moteur
   function strat(logic : in T_logic, game : in T_game, history : in T_history) return string;

   function min(a : in float, b : in float) return float;
   function min(a : in integer, b : in integer) return float;       
   function percent_bluff(a : in float, b : in integer) return float;

Private
   --Constantes des seuils de winning chances
 
   HIGH : constant Float := 0.9;
   MEDIUM : constant Float := 0.75;
   LOW : constant Float := 0.5;
   
   --Pourcentage de raise pour adversaire idiot
   
   IDIOT_OWN : constant float :=0.2;
   IDIOT_OP : constant float :=0.5;
   
   --Pourcentage de raise pour adversaire intelligent
   INT_HIGH : constant float := 0.15;
     
   
   
   
   PERCENT_BLUFF : constant float := 0.20;
   EQUIVALENT : constant float := 0.50;  --comparaison stack esperance
end Mastermind;
