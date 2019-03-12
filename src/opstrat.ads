with utils, read_preflop;
use utils, read_preflop;

package opstrat is

   type T_action is private;
   type T_action_list is private;
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
   procedure add_chances(logic : in out T_logic; chances : in Float);
   
   function get_avg_chances(logic : T_logic) return Float;
   function get_min_chances(logic : T_logic) return Float;
   
   function get_can_bluff(logic : T_logic) return Boolean;
   function get_can_semi_bluff(logic : T_logic) return Boolean;
   function get_can_get_bluffed(logic : T_logic) return Boolean;
   function get_has_logic(logic : T_logic) return Boolean;
   
   function get_winning_chances(logic : T_logic) return Float;
   
   function get_nbr_of_bluff(logic : T_logic) return Float;
   function get_nbr_of_semi_bluff(logic : T_logic) return Float;
   function get_nbr_of_bluffed(logic : T_logic) return Float;
   
private
   
   type T_action is record 
      move : T_move;
      table : T_set;
      bet : Integer := -1;
   end record;
   
   type T_action_list is array(0..10) of T_action;
      
   type T_history is record
      hand : T_set;
      list : T_action_list;
      size : Integer;
   end record;
   
   type T_list_chances is Array(1..75) of Float;

   type T_logic is record
      can_bluff       : Boolean := FALSE;
      can_semi_bluff  : Boolean := FALSE;
      can_get_bluffed : Boolean := FALSE;
      has_logic       : Boolean := TRUE;
         
      nbr_of_bluff      : Float := 0.0;
      nbr_of_semi_bluff : Float := 0.0;
      nbr_of_bluffed    : Float := 0.0;
      
      winning_chances : Float := 0.0;
      
      chances_taken : T_list_chances;
      list_size : Integer := 0;
      
      min_chances_taken : Float := 0.0;
      avg_chances_taken : Float := 0.0;
      end record;
   
end opstrat;
