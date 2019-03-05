procedure opstrat is
begin
  
   procedure add_T_action(h : T_history; move : T_move; table : T_set; bet : Integer := 0) is
   begin
      h.table = table;
      if(move = bet) then
         h(h.size) := (move, bet);
      else
         h(h.size) := (move);
      end if;
   end add_T_action;
   
   function getMove(h : T_history; i : Integer) return T_move is
   begin
      if (i < h.size) then
         return h(i).move;
      else
         return null;
      end if;
   end getMove;
      
   function getBet(h : T_history; i : Integer) return Integer is
   begin
      if (getMove(h, i) = bet) then
         return h(i).bet;
      else return -1;
      end if;
   end getBet;
   
   function getSize(h : T_history) return Integer is
   begin
      return h.size;
   end getSize;
   
   function opIsBluffing(op_hand : in T_set; history : in T_history) return Float is
      r : Float;
   begin
      
      --Si l'op a peu de chances de gagner, mais mise quand même, il bluff (r=1)
      --On diminue les chances linéairement de 0.5 à 0.75 jusqu'à atteindre 0, où la probabilité qu'il bluffe est estimée nulle
      if(Get_Winning_Chance(op_hand.set(0), op_hand.set(1)) < 0.5 and getBet(history, 0) > 0) then
         r := 1.0;
      elsif(Get_Winning_Chance(op_hand.set(0), op_hand.set(1)) < 0.75 and getBet(history, 0) > 0) then
         r := 3.0 - Get_Winning_Chance(op_hand.set(0), op_hand.set(1))*4;
      else
         r := 0.0;
      end if;
      
      return r;
   end opIsBluffing;
   
   procedure add_bluff(logic : in out T_logic; r : in Float) is
      r : Float;
   begin
      return r;
   end add_bluff;
   
   procedure add_semi_bluff(logic : in out T_logic; r : in Float) is
      r : Float;
   begin
      return r;
   end add_semi_bluff;
   
   procedure add_bluffed(logic : in out T_logic; r : in Float) is
      r : Float;
   begin
      return r;
   end add_bluffed;
   
   procedure add_chances(logic : in out T_logic; chances : in Float) is
      r : Float;
   begin
      return r;
   end add_chances;
   
   function get_avg_chances(logic : T_logic) return Float is
      r : Float;
   begin
      return r;
   end get_avg_chances;
   
   function get_min_chances(logic : T_logic) return Float is
      r : Float;
   begin
      return r;
   end get_min_chances;
   
   function get_can_bluff(logic : T_logic) return Boolean is
      r : Boolean;
   begin
      return r;
   end get_can_bluff;
   
   function get_can_semi_bluff(logic : T_logic) return Boolean is
      r : Boolean;
   begin
      return r;
   end get_can_semi_bluff;
   
   function get_can_get_bluffed(logic : T_logic) return Boolean is
      r : Boolean;
   begin
      return r;
   end get_can_get_bluffed;
   
   function get_has_logic(logic : T_logic) return Boolean is
      r : Boolean;
   begin
      return r;
   end get_has_logic;
   
   function get_winning_chances(game : T_game) return Float is
      r : Float;
   begin
      return r;
   end get_winning_chances;
   
   function get_nbr_of_bluff(logic : T_logic) return Float is
      r : Float;
   begin
      return r;
   end get_nbr_of_bluff;
   
   function get_nbr_of_semi_bluff(logic : T_logic) return Float is
      r : Float;
   begin
      return r;
   end get_nbr_of_semi_bluff;
   
   function get_nbr_of_bluffed(logic : T_logic) return Float is
      r : Float;
   begin
      return r;
   end get_nbr_of_bluffed;
   
end opstrat;
