package body read_preflop is

   Function Get_Winning_Chance (card1 : T_card; card2 : T_card) return Float is
      x,y : Integer;
   Begin
      if card1.colour = card2.colour then
         x := integer'Min(card1.rank,card2.rank);
         y := integer'Max(card1.rank,card2.rank);
      else 
         y := integer'Min(card1.rank,card2.rank);
         x := integer'Max(card1.rank,card2.rank);
      end if;
      return getFromArray(Win_Array,x,y) / 2097572400;
   end Get_Winning_Chance;
   
   Function Get_Losing_Chance (card1 : T_card; card2 : T_card) return Float is
      x,y : Integer;
   Begin
      if card1.colour = card2.colour then
         x := integer'Min(card1.rank,card2.rank);
         y := integer'Max(card1.rank,card2.rank);
      else 
         y := integer'Min(card1.rank,card2.rank);
         x := integer'Max(card1.rank,card2.rank);
      end if;
      return getFromArray(Lose_Array,x,y) / 2097572400;
   end Get_Losing_Chance;
                                    
    
   Function Get_Tie_Chance (card1 : T_card; card2 : T_card) return Float is
   Begin
      return 1- Get_Losing_Chance(card1,card2) - Get_Winning_Chance(card1,card2);
   end Get_Tie_Chance;
   
                                    
   function getFromArray(lst : T_array_chance; x : Integer; y : Integer) return Integer is
   begin
      return lst(13*x+y);
   end getFromArray;
   
   
   
   
end read_preflop;
