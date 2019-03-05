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
         r := 3.0 - Get_Winning_Chance(op_hand.set(0), op_hand.set(1)*4;
      else
         r := 0.0;
      end if;
      
      return r;
   end opIsBluffing;
end opstrat;
