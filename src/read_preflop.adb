with utils, ada.Text_IO; use utils, Ada.Text_IO;
package body read_preflop is

   Function Get_Winning_Chance (card1 : T_card; card2 : T_card) return Float is
      x,y : Integer;
   Begin
      if get_colour(card1) = get_colour(card2) then
         y := integer'Min(get_rank(card1),get_rank(card2));
         x := integer'Max(get_rank(card1),get_rank(card2));
      else 
         x := integer'Min(get_rank(card1),get_rank(card2));
         y := integer'Max(get_rank(card1),get_rank(card2));
      end if;
      put_line("x= " & integer'image(x) & " ; y= " & integer'image(y));
      return float(getFromArray(WIN_ARRAY,x,y)) / 2097572400.0;
   end Get_Winning_Chance;
   
   Function Get_Losing_Chance (card1 : T_card; card2 : T_card) return Float is
      x,y : Integer;
   Begin
      if get_colour(card1) = get_colour(card2) then
         y := integer'Min(get_rank(card1),get_rank(card2));
         x := integer'Max(get_rank(card1),get_rank(card2));
      else 
         x := integer'Min(get_rank(card1),get_rank(card2));
         y := integer'Max(get_rank(card1),get_rank(card2));
      end if;
      put_line("x= " & integer'image(x) & " ; y= " & integer'image(y));
      return float(getFromArray(LOSE_ARRAY,x,y)) / 2097572400.0;
   end Get_Losing_Chance;
                                    
    
   Function Get_Tie_Chance (card1 : T_card; card2 : T_card) return Float is
      x,y : Integer;
   Begin
     if get_colour(card1) = get_colour(card2) then
         y := integer'Min(get_rank(card1),get_rank(card2));
         x := integer'Max(get_rank(card1),get_rank(card2));
      else 
         x := integer'Min(get_rank(card1),get_rank(card2));
         y := integer'Max(get_rank(card1),get_rank(card2));
      end if;
      put_line("x= " & integer'image(x) & " ; y= " & integer'image(y));
      return float(getFromArray(TIE_ARRAY,x,y)) / 2097572400.0;
   end Get_Tie_Chance;
   
                                    
   function getFromArray(lst : T_array_chance; x : Integer; y : Integer) return Integer is
   begin
      return lst(13*(12-x)+(12-y));
   end getFromArray;
   
   
   
   
end read_preflop;
