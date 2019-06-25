with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;


package Mastermind is

   
   
   -- /E: game : T_game
   -- /E: logic : T_logic
   --/N�cessite : tous les numeriques du t_logic >=0
   --/S : string
   -- Entraine : donne le message a retouner au moteur
   function strat(logic : in T_logic; game : in T_game) return T_round;
   
   
   --surcharges
   function "*"(a : in integer; b : in float) return float;
   function "*"(a : in float; b : in integer) return float;
   
   function "/"(a : in integer; b : in float) return float;
   function "/"(a : in float; b : in integer) return float;
   
   function "<"(a : in integer; b : in float) return Boolean;
   function "<"(a : in float; b : in integer) return Boolean;
   
   function ">"(a : in integer; b : in float) return Boolean;
   function ">"(a : in float; b : in integer) return Boolean;

   --Constantes des seuils de winning chances
 
   HIGH : constant Float := 0.85;
   MEDIUM : constant Float := 0.80;
   LOW : constant Float := 0.62;
   
   --Pourcentage de raise pour adversaire idiot
   
   IDIOT_OWN : constant float :=0.05;
   IDIOT_OP : constant float :=0.1;
   
   --Pourcentage de raise pour adversaire intelligent
   INT_HIGH : constant float := 0.10;
   INT_LOW : constant float := 0.05;
   
   --Comparaison esperance gain et propre stack
   SMALL_ESP : constant float := 0.1;
   BIG_ESP : constant float :=0.5;
     
   
   --Taux de bluff de l'adversaire dans la partie
   PERCENT_BLUFF : constant float := 0.15;
   Private
   function bluff(game : in T_game) return T_round;

end Mastermind;
