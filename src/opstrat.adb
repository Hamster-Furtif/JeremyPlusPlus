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
   
end opstrat;
