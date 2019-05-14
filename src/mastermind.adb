with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;

package body mastermind is
   
   
   function min(a : in float; b : in float) return float is
   begin 
      if a > b then
         return b;
      else 
         return a;
      end if;
   end min;
   
   function min(a : in integer; b : in integer) return float is
      begin 
      if a > b then
         return float(b);
      else 
         return float(a);
      end if;
   end min;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   function strat(logic : in T_logic; game : in T_game, history : in T_history) return string is
   
   
   begin
   
      if not(get_can_bluff(logic)) then --l'adversaire ne sait pas bluffer
         if not(get_can_get_bluffed(logic)) then --l'adversaire detecte notre bluff
                                                 -- l'adversaire joue uniquement d'apres ses cartes, on reutilise la strategie du S1
                                                 
            if (get_winning_chances(logic) >= 0.8) then
               bet := Integer'Max(Integer'Min(100 + Integer(get_winning_chances(logic)*Float(100)), get_op_money(game) ), get_min_bet(game));
               return("bet" & Integer'Image(bet));
            elsif(get_winning_chances(logic) >= 0.5 or ( get_winning_chances(logic) >= 0.0 and get_size(get_table(game)) = 0)) then
               return("call");
            else
               return("check");
            end if;
         else 
                                                 -- adversaire idiot (il ne sait pas bluffer et ne detetcte pas notre bluff), on bluffe tout le temps
            return ("raise " & 
                     float'image(min(float(amount_to_call)+IDIOT_OWN*game.my_money,float(amount_to_call)+IDIOT_OP*game.op_money)));
         end if;
      else
         if not(get_can_get_bluffed(logic)) then --l'adversaire sait bluffer et detecte notre propre bluff
            
            
            if get_winning_chances(logic) >= HIGH then                                                -- on a de grandes chances de gagner
               return("raise " & float'image(float(amount_to_call) + INT_HIGH * get_my_money(game)));
                  
            elsif MEDIUM<=get_winning_chances(logic) and get_winning_chances(logic)<HIGH then         -- on a des chances moyennes de gagner
               if get_nbr_of_bluff(logic : T_logic)/get_roud(game) > PERCENT_BLUFF then                     -- l'adversaire bluffe souvent
                  return("call");
               else                                                                                         -- l'adversaire bluffe peu
                  if (getExpectation(logic,game,history) > 0 and abs(getExpectation(logic,game,history)) > BIG_ESP*game.my_money) then
                     return("raise " & float'image(float(amount_to_call) + INT_LOW * get_my_money(game)));     -- l'esperance de gain est tres elevee
                     
                  elsif (getExpectation(logic,game,history) < 0 and abs(getExpectation(logic,game,history)) < SMALL_ESP*game.my_money) OR getExpectation(logic,game,history)>0 then
                     return("call");                                                                           -- on a une esperance positive ou legerement negative 
                      
                  else                                                                                         -- l'esperance de gain est siginificativement negative
                     return("check");
                  end if ;
               
               end if;
            
            else                                                                                       -- on peu de chances de gagner
               return("check");
            
            end if;
            
         else                                   -- l'adversaire sait bluffer mais ne detecte pas notre propre bluff
            
         end if ;
      end if;
   
   
   
   
   
   
   end strat;
   
   
   
   
   
   
   
   
   
end mastermind;
