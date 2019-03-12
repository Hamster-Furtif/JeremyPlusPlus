with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;

package body mastermind is
   
   
   function min(a : in float, b : in float) return float is
   begin 
      if a > b then
         return b;
      else 
         return a;
      end if
   end min;
   
   function min(a : in integer, b : in integer) return float is
      begin 
      if a > b then
         return float(b);
      else 
         return float(a);
      end if
   end min;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   function strat(logic : in T_logic, game : in T_game, history : in T_history) return string is
   
   
   begin
   
      if not(get_can_bluff(logic)) then
         if not(get_can_get_bluffed(logic)) then -- l'adversaire joue uniquement d'apres ses cartes
                                                 -- on reutilise la strat du S1
            if (winning_chances >= 0.8) then
               bet := Integer'Max(Integer'Min(100 + Integer(winning_chances*Float(100)), game.op_money), game.min_bet);
               return("bet" & Integer'Image(bet));
            elsif(winning_chances >= 0.5 or ( winning_chances >= 0.0 and game.table.size = 0)) then
               return("call");
            else
               return("check");
            end if;
         else 
            -- adversaire idiot, on bluffe tout le temps
            return ("raise " & 
                     float'image(min(float(amount_to_call)+IDIOT_OWN*game.my_money,float(amount_to_call)+IDIOT_OP*game.op_money)));
         end if;
      else
         if not(get_can_get_bluffed(logic)) then 
            
            if game.table.size =3 then
               
            elsif game.table.size =4 then
               
            else 
               if get_winning_chances(logic) >= HIGH then
                  return("raise " & float'image(float(amount_to_call)+INT_HIGH*game.my_money));
                  
               elsif MEDIUM<=get_winning_chances(logic) and get_winning_chances(logic)<HIGH then
                  if get_nbr_of_bluff(logic : T_logic)/game.round > PERCENT_BLUFF then
                     return("call");
                  else 
                     if getExpectation(logic,game,history) < 0 and abs(getExpectation(logic,game,history)) > EQUIVALENT*game.my_money then
                        if game.amount_to_call = 0 then
                           return ("check");
                        else
                           return("fold");
                        end if;
                    
                         
                        
                     
                  
               end if ;
               
               
            end if;
          else 
            
         end if;
      end if ;
      
   
   
   
   
   
   
   end strat;
   
   
   
   
   
   
   
   
   
end mastermind;
