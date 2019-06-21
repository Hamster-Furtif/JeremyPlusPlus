with ada.Text_IO, opstrat, utils;
use ada.Text_IO, opstrat, utils;

package body  mastermind is
   
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
   
   
   function strat(logic : in T_logic; game : in T_game) return T_round is
   begin
      
      
      if(can_get_bluffed(logic)) then
         return bluff(game);
      else
         -----------------------------------
         --l'adversaire ne sait pas bluffer-
         -----------------------------------
         if not(can_bluff(logic)) then 
                                       
            --Si on a de grandes chances de gagner, on mise baucoup d'argent
            if (get_winning_chances(logic) >= HIGH) then
               return(create_round(bet, Integer'Max(Integer'Min(100 + Integer(get_winning_chances(logic)*Float(100)), get_op_money(game)), get_min_bet(game))));
            
               --Si les chances de gagner sont faibles ou
               --si on est au début du round, on call
            elsif(get_winning_chances(logic) >= LOW or (get_winning_chances(logic) >= 0.0 and get_size(get_table(game)) = 0)) then
               return(create_round(call,-1));
               
               --Si les chances de gagner sont très faibles, on check (fold si l'adversaire a misé)
            else
               return(create_round(check,-1));
            end if;

       
         
            ----------------------------
            --l'adversaire sait bluffer-
            ----------------------------
         else
            if get_winning_chances(logic) >= HIGH then                                                -- on a de grandes chances de gagner
               return(create_round(bet,integer(float(get_amount_to_call(game)) + INT_HIGH*get_my_money(game))));
                  
            elsif get_winning_chances(logic) > MEDIUM then         -- on a des chances moyennes de gagner
               if get_nbr_of_bluff(logic)/get_round(game) > PERCENT_BLUFF then                     -- l'adversaire bluffe souvent
                  return(create_round(call,-1));
               else                                                                                         -- l'adversaire bluffe peu
                  if get_expectation(logic,game) > float(BIG_ESP*get_my_money(game)) then
                     return(create_round(bet, integer(float(get_amount_to_call(game)) + INT_LOW * get_my_money(game))));     -- l'esperance de gain est tres elevee
                     
                  elsif (get_expectation(logic,game) < 0 and abs(get_expectation(logic,game)) < SMALL_ESP*get_my_money(game)) OR get_expectation(logic, game)>0 then
                     return(create_round(call, -1));                                                                           -- on a une esperance positive ou legerement negative 
                      
                  else                                                                                         -- l'esperance de gain est siginificativement negative
                     return(create_round(check,-1));
                  end if ;
               
               end if;
            
            else                                                                                       -- on a peu de chances de gagner
               return(create_round(check,-1));
            
            end if;
         end if;
      end if;
   
   end strat;
   
   
   
   function bluff(game : in T_game) return T_round is
   begin
       return (create_round(bet, integer(float'min(float(get_amount_to_call(game))+IDIOT_OWN*get_my_money(game),float(get_amount_to_call(game))+IDIOT_OP*get_op_money(game)))));
   end bluff;
   

   
   
   
   
   
end mastermind;
