with utils, read_preflop;
use utils, read_preflop;

package opstrat is

   type T_round is private;
   type T_logic is private;
   
   --E/op_hand : T_set
   --Necessite : Op_hand contient 2 cartes
   --S/proba : Float
   --Entraine : Calcule la probabilite que l'adversaire ait bluffe lors d'un round
   function opIsBluffing(op_hand : in T_set) return float;
   
   --E/r : Float
   --E/S/ logic : T_logic
   --Necessite : None
   --Entraine : actualise le nombre de bluff de l'adversaire dans la partie et le booleen can_bluff
   procedure add_bluff(logic : in out T_logic; r : in Float);
   --E/r : Float
   --E/S/ logic : T_logic
   --Necessite : None
   --Entraine : actualise le nombre de semi-bluff de l'adversaire dans la partie et le booleen can_semi_bluff
   procedure add_semi_bluff(logic : in out T_logic; r : in Float);
   --E/r : Float
   --E/S/ logic : T_logic
   --Necessite : None
   --Entraine : actualise le nombre de fois ou l'adversaire nous a bluffe 
   procedure add_bluffed(logic : in out T_logic; r : in Float);
   
   --accesseurs en lecture
   function can_bluff(logic : T_logic) return Boolean;
   function can_semi_bluff(logic : T_logic) return Boolean;
   function can_get_bluffed(logic : T_logic) return Boolean;
   function has_logic(logic : T_logic) return Boolean;
   
   function get_winning_chances(logic : T_logic) return Float;

   function get_nbr_of_bluff(logic : T_logic) return Float;
   function get_nbr_of_semi_bluff(logic : T_logic) return Float;
   function get_nbr_of_bluffed(logic : T_logic) return Float;
   
   
   function create_round(move : T_move; bet : Integer) return T_round;
   function toString(round: T_round) return String;
   procedure set_winning_chances(logic : in out T_logic;chances : Float);
   procedure set_current_move(logic : in out T_logic; move: T_move);
   function get_current_move(logic : in T_logic) return T_move;
  
   -- E/ logic   T_logic
   -- E/ game    T_game
   -- S/ esp     Float
   -- Entraine esp l'estimation de l'esperance de gain de la main en cours, avec les probabilites de bluff de l'adversaire
   function get_expectation(logic : T_logic; game : T_game) return Float;
   
   
private
   
   -- Correspond à l'action prise lors d'un tour par l'adversaire, ainsi que la table, le bet et la main de l'adversaire.
   type T_round is record 
      move : T_move;
      table : T_set;
      op_hand : T_set;
      bet : Integer := -1;
   end record;

   type T_logic is record
      can_bluff       : Boolean := FALSE;
      can_semi_bluff  : Boolean := FALSE;
      can_get_bluffed : Boolean := FALSE;
      has_logic       : Boolean := TRUE;
      current_move    : T_move := none;
         
      nbr_of_bluff      : Float := 0.0;
      nbr_of_semi_bluff : Float := 0.0;
      nbr_of_bluffed    : Float := 0.0;
      
      bluff_possibilities : Float := 0.0;
      semi_bluff_possibilities : Float := 0.0;
      bluffed_possibilities : Float := 0.0;
     
      p_bluff : Float := 0.0;
      p_bluffed : Float := 0.0;
      p_semi_bluffed : Float := 0.0;
      winning_chances   : Float := 0.0;
      esp_gain          : Float := 0.0;
      
      end record;
   
end opstrat;
