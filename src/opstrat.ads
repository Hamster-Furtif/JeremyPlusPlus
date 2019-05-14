with utils, read_preflop;
use utils, read_preflop;

package opstrat is

   type T_round is private;
   type T_round_list is private;
   type T_history is private;
   type T_logic is private;
   
   procedure add_T_action(h : in out T_history; move : in T_move; table : in T_set; bet : in Integer := -1);
   
   function getMove(h : in T_history; i : in Integer) return T_move;
   function getBet(h : in T_history; i : in Integer) return Integer;
   function getSize(h : in T_history) return Integer;
   function opIsBluffing(op_hand : in T_set; history : in T_history) return float;
   
   procedure add_bluff(logic : in out T_logic; r : in Float);
   procedure add_semi_bluff(logic : in out T_logic; r : in Float);
   procedure add_bluffed(logic : in out T_logic; r : in Float);
   
   function get_avg_chances(logic : T_logic) return Float;
   
   function can_bluff(logic : T_logic) return Boolean;
   function can_semi_bluff(logic : T_logic) return Boolean;
   function can_get_bluffed(logic : T_logic) return Boolean;
   function has_logic(logic : T_logic) return Boolean;
   
   function get_winning_chances(logic : T_logic) return Float;

   function get_nbr_of_bluff(logic : T_logic) return Float;
   function get_nbr_of_semi_bluff(logic : T_logic) return Float;
   function get_nbr_of_bluffed(logic : T_logic) return Float;
   
   function create_round(move : T_move; bet : Integer) return T_round;
   
   
   -- E/ logic   T_logic
   -- E/ game    T_game
   -- E/ history T_history
   -- S/ esp     Float
   -- Entraine esp l'estimation de l'esperance de gain de la main en cours, avec les probabilites de bluff de l'adversaire
   function get_expectation(logic : T_logic; game : T_game; history : T_history) return Float;
   
   
   
private
   
   -- Correspond à l'action prise lors d'un tour par l'adversaire, ainsi que la table, le bet et la main de l'adversaire.
   type T_round is record 
      move : T_move;
      table : T_set;
      op_hand : T_set;
      bet : Integer := -1;
   end record;
   
   type T_round_list is array(0..50) of T_round;
  
   -- Correspond aux listes des actions
   type T_history is record
      rounds  : T_round_list;
      size    : Integer;
   end record;

   type T_logic is record
      can_bluff       : Boolean := FALSE;
      can_semi_bluff  : Boolean := FALSE;
      can_get_bluffed : Boolean := FALSE;
      has_logic       : Boolean := TRUE;
         
      nbr_of_bluff      : Float := 0.0;
      nbr_of_semi_bluff : Float := 0.0;
      nbr_of_bluffed    : Float := 0.0;
      
      winning_chances   : Float := 0.0;
      avg_chances_taken : Float := 0.0;
      esp_gain          : Float := 0.0;
      
      end record;
   
end opstrat;
