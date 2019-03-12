package body opstrat is
  
   procedure add_T_action(h : in out T_history; move : in T_move; table : in T_set; bet : in Integer := -1) is
   begin
      h.list(h.size).move := move;
      h.list(h.size).bet := bet;
      h.size := h.size + 1;
   end add_T_action;
   
   function getMove(h : in T_history; i : in Integer) return T_move is
   begin
      if (i < h.size) then
         return h.list(i).move;
      else
         return none;
      end if;
   end getMove;
      
   function getBet(h : in T_history; i : in Integer) return Integer is
   begin
      return h.list(i).bet;
   end getBet;
   
   function getSize(h : in T_history) return Integer is
   begin
      return h.size;
   end getSize;
   
   function opIsBluffing(op_hand : in T_set; history : in T_history) return Float is
      r : Float;
   begin
      
      --Si l'op a peu de chances de gagner, mais mise quand même, il bluff (r=1)
      --On diminue les chances linéairement de 0.5 à 0.75 jusqu'à atteindre 0, où la probabilité qu'il bluffe est estimée nulle
      if(get_winning_chance(op_hand.set(0), op_hand.set(1)) < 0.5 and getBet(history, 0) > 0) then
         r := 1.0;
      elsif(Get_Winning_Chance(op_hand.set(0), op_hand.set(1)) < 0.75 and getBet(history, 0) > 0) then
         r := 3.0 - Get_Winning_Chance(op_hand.set(0), op_hand.set(1))*4.0;
      else
         r := 0.0;
      end if;
      
      return r;
   end opIsBluffing;
   
   procedure add_bluff(logic : in out T_logic; r : in Float) is
   begin
      logic.nbr_of_bluff := logic.nbr_of_bluff + r;
      if(logic.nbr_of_bluff > 2.0) then
         logic.can_bluff := TRUE;
      end if;
      
   end add_bluff;
   
   procedure add_semi_bluff(logic : in out T_logic; r : in Float) is
   begin
      logic.nbr_of_semi_bluff := logic.nbr_of_semi_bluff + r;
      if(logic.nbr_of_semi_bluff > 2.5) then
         logic.can_semi_bluff := TRUE;
      end if;
      end add_semi_bluff;
   
   procedure add_bluffed(logic : in out T_logic; r : in Float) is
   begin
      logic.nbr_of_bluffed := logic.nbr_of_bluffed + r;
      if(logic.nbr_of_bluffed > 2.0) then
         logic.can_get_bluffed := TRUE;
         end if;
   end add_bluffed;
   
   procedure add_chances(logic : in out T_logic; chances : in Float) is
   begin
      logic.list_size := logic.list_size + 1;
      logic.chances_taken(logic.list_size) := chances;
   end add_chances;
   
   function get_avg_chances(logic : T_logic) return Float is
   begin
      return logic.avg_chances_taken;
   end get_avg_chances;
   
   function get_min_chances(logic : T_logic) return Float is
   begin
      return logic.min_chances_taken;
   end get_min_chances;
   
   function get_can_bluff(logic : T_logic) return Boolean is
   begin
      return logic.can_bluff;
   end get_can_bluff;
   
   function get_can_semi_bluff(logic : T_logic) return Boolean is
   begin
      return logic.can_semi_bluff;
   end get_can_semi_bluff;
   
   function get_can_get_bluffed(logic : T_logic) return Boolean is
   begin
      return logic.can_get_bluffed;
   end get_can_get_bluffed;
   
   function get_has_logic(logic : T_logic) return Boolean is
   begin
      return logic.has_logic;
   end get_has_logic;
   
   function get_winning_chances(logic : T_logic) return Float is
   begin
      return logic.winning_chances;
   end get_winning_chances;
   
   function get_nbr_of_bluff(logic : T_logic) return Float is
   begin
      return logic.nbr_of_bluff;
   end get_nbr_of_bluff;
   
   function get_nbr_of_semi_bluff(logic : T_logic) return Float is
     begin
      return logic.nbr_of_semi_bluff;
   end get_nbr_of_semi_bluff;
   
   function get_nbr_of_bluffed(logic : T_logic) return Float is
     begin
      return logic.nbr_of_bluffed;
   end get_nbr_of_bluffed;
   
end opstrat;
