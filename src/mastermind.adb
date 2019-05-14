with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;

package body  mastermind is
   
   
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
   
   function ValAbs(a : float) return float is
   Begin
      if a<0 then
           return a*(-1.0);
      else 
         return a;
      end if;
      
   end ValAbs;
      
   
   
   
   function "*"(a : in integer; b : in float) return float is
   Begin
      return float(a)*b;
   end "*";
   
   function "*"(a : in float; b : in integer) return float is
   begin 
      return b*a;
   end "*";
   
   function "/"(a : in integer; b : in float) return float is
   Begin
      return float(a)/b;
   end "/";
   
   function "/"(a : in float; b : in integer) return float is
   begin 
      return a/float(b);
   end "/";
   
   function "<"(a : in integer; b : in float) return Boolean is
   begin
      return float(a) < b;
   end "<";
   
     
   function "<"(a : in float; b : in integer) return Boolean is
   begin
      return a < float(b);
   end "<";
   

   function ">"(a : in integer; b : in float) return Boolean is
   begin
      return float(a)>b;
   end ">";
   
   function ">"(a : in float; b : in integer) return Boolean is
   begin
      return a > float(b);
   end ">";
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   function strat(logic : in T_logic; game : in T_game; history : in T_history) return T_round is
   
   
   begin
      
      
      if not(can_bluff(logic)) then --l'adversaire ne sait pas bluffer
         if not(can_get_bluffed(logic)) then --l'adversaire detecte notre bluff
                                                 -- l'adversaire joue uniquement d'apres ses cartes, on reutilise la strategie du S1
                                                 
            if (get_winning_chances(logic) >= 0.8) then
               return(create_round(bet, Integer'Max(Integer'Min(100 + Integer(get_winning_chances(logic)*Float(100)), get_op_money(game) ), get_min_bet(game))));
            elsif(get_winning_chances(logic) >= 0.5 or ( get_winning_chances(logic) >= 0.0 and get_size(get_table(game)) = 0)) then
               return(create_round(call,-1));
            else
               return(create_round(check,-1));
            end if;
         else 
                                                 -- adversaire idiot (il ne sait pas bluffer et ne detetcte pas notre bluff), on bluffe tout le temps
            return (create_round(bet,integer(min(float(get_amount_to_call(game))+IDIOT_OWN*get_my_money(game),float(get_amount_to_call(game))+IDIOT_OP*get_op_money(game)))));
         end if;
      else
         if not(can_get_bluffed(logic)) then --l'adversaire sait bluffer et detecte notre propre bluff
            
            
            if get_winning_chances(logic) >= HIGH then                                                -- on a de grandes chances de gagner
                       return(create_round(bet,integer(float(get_amount_to_call(game)) + INT_HIGH*get_my_money(game))));
                  
            elsif MEDIUM<=get_winning_chances(logic) and get_winning_chances(logic)<HIGH then         -- on a des chances moyennes de gagner
               if get_nbr_of_bluff(logic)/get_round(game) > PERCENT_BLUFF then                     -- l'adversaire bluffe souvent
                  return(create_round(call,-1));
               else                                                                                         -- l'adversaire bluffe peu
                  if (get_expectation(logic,game,history) > 0 and ValAbs(get_expectation(logic,game,history)) > float(BIG_ESP*get_my_money(game))) then
                     return(create_round(bet, integer(float(get_amount_to_call(game)) + INT_LOW * get_my_money(game))));     -- l'esperance de gain est tres elevee
                     
                  elsif (get_expectation(logic,game,history) < 0 and ValAbs(get_expectation(logic,game,history)) < SMALL_ESP*get_my_money(game)) OR get_expectation(logic,game,history)>0 then
                     return(create_round(call, -1));                                                                           -- on a une esperance positive ou legerement negative 
                      
                  else                                                                                         -- l'esperance de gain est siginificativement negative
                     return(create_round(check,-1));
                  end if ;
               
               end if;
            
            else                                                                                       -- on a peu de chances de gagner
               return(create_round(check,-1));
            
            end if;
            
         else
                return (create_round(bet, integer(min(float(get_amount_to_call(game))+IDIOT_OWN*get_my_money(game),float(get_amount_to_call(game))+IDIOT_OP*get_op_money(game)))));
         end if;                             -- l'adversaire sait bluffer mais ne detecte pas notre propre bluff
                                             -- meme strategie que pour l'adversaire idiot, on bluff tout le temps
      end if;
  
   
   end strat;
   
   
   
   
   
   
   
   
   
end mastermind;
