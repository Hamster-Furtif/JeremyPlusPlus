with Ada.Characters.Handling,Ada.Text_IO;
use Ada.Characters.Handling,Ada.Text_IO;

package body opstrat is
  
   
   function opIsBluffing(op_hand : in T_set) return Float is
      r : Float;
   begin
      
      --Si l'op a peu de chances de gagner, mais mise quand même, il bluff (r=1)
      --On diminue les chances linéairement de 0.5 à 0.75 jusqu'à atteindre 0, où la probabilité qu'il bluffe est estimée nulle
      if(Get_Winning_Chance(get_card(op_hand, 0), get_card(op_hand, 1)) < 0.5) then
         r := 1.0;
      elsif(Get_Winning_Chance(get_card(op_hand, 0), get_card(op_hand, 1)) < 0.75) then
         r := 3.0 - Get_Winning_Chance(get_card(op_hand, 0), get_card(op_hand, 1))*4.0;
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
   

   function can_bluff(logic : T_logic) return Boolean is
   begin
      return logic.can_bluff;
   end can_bluff;
   
   function can_semi_bluff(logic : T_logic) return Boolean is
   begin
      return logic.can_semi_bluff;
   end can_semi_bluff;
   
   function can_get_bluffed(logic : T_logic) return Boolean is
   begin
      return logic.can_get_bluffed;
   end can_get_bluffed;
   
   function has_logic(logic : T_logic) return Boolean is
   begin
      return logic.has_logic;
   end has_logic;
   
   
   function get_winning_chances(logic : T_logic) return Float is
   begin
      return logic.winning_chances;
   end get_winning_chances;
   procedure set_winning_chances(logic : in out T_logic;chances : Float) is
   begin
      logic.winning_chances := chances;
   end set_winning_chances;
   
   
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
   
   function get_expectation(logic : T_logic; game : T_game) return Float is
      e : Float := 0.0;
      eb : Float := Float(get_pot(game) - get_min_bet(game));
      ob : Float := Float(get_min_bet(game));
      P_we_bluff : Float := 0.2; -- valeur arbitraire. On estime qu'on bluffe 20% du temps ...
      P_bluffed : Float := logic.nbr_of_bluffed / logic.bluffed_possibilities;
      P_bluff : Float := logic.nbr_of_bluff / logic.bluff_possibilities;
      win_chances : Float := logic.winning_chances;
      los_chances : Float := 1.0 - win_chances - P_bluff - P_bluffed;
   begin
      e := eb*(P_we_bluff*P_bluffed + win_chances ) - ob*(P_bluff+los_chances);
      
      return e;
   end get_expectation;
   
   function create_round(move : T_move; bet : Integer) return T_round is
      round : T_round;
   begin
      round.move := move;
      round.bet := bet;
      return round;
   end create_round;
   
   function toString(round: T_round) return String is
   begin
      if(round.bet = -1) then
         return To_Lower(round.move'Img);
      else
         return To_Lower(round.move'Img &round.bet'Img);
      end if;
   end toString;
   
end opstrat;
