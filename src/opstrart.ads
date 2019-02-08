with utils;
use utils;

package opstrart is

   type T_action is private;
   type T_action_list is private;
   type T_history is private;
   
   procedure add_T_action(h : T_history; move : T_move; table : T_set; bet : Integer := 0);
   function getMove(h : T_history; i : Integer) return T_move;
   function getBet(h : T_history; i : Integer) return Integer;
   function getSize(h : T_history) return Integer;

   
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

end opstrart;
