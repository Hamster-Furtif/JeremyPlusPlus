with utils;
use utils;

package opstrat is

   type T_action      is private;
   type T_action_list is private;
   type T_history     is private;
   type T_op_logic    is private;
   
   procedure add_T_action(h : T_history; move : T_move; table : T_set; bet : Integer := 0);
   function getMove(h : T_history; i : Integer) return T_move;
   function getBet(h : T_history; i : Integer) return Integer;
   function getSize(h : T_history) return Integer;
   function opIsBluffing(op_hand : in T_set; history : in T_history) return float;
   
   procedure add_bluff(logic : T_logic; r : Float);
   procedure add_semi_bluff(logic : T_logic; r : Float);
   procedure add_bluffed(logic : T_logic; r : Float);
   procedure add_chances(logic : T_logic; chances : Float)
   
private
   
   type T_action(m : T_move) is record 
      move : T_move := m;
      table : T_set;
      case m is
         when bet => bet : Integer;
         when others => null;
      end case;
   end record;
   
   type T_action_list is array(0..10) of T_action;
      
   type T_history is record
      hand : T_set;
      list : T_action_list;
      size : Integer;
   end record;

   type T_logic is record
      can_bluff       : Boolean := FALSE;
      can_semi_bluff  : Boolean := FALSE;
      can_get_bluffed : Boolean := FALSE;
      has_logic       : Boolean := TRUE;
         
      nbr_of_bluff      : Float := 0;
      nbr_of_semi_bluff : Float := 0;
      nbr_of_bluffed    : Float := 0;
      
      chances_taken : Array(1..75) of Float;
      min_chances_taken : Float := 0;
      avg_chances_taken : Float := 0;
      end record;
   
end opstrat;
