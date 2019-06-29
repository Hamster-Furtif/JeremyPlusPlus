with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
with read_preflop; use read_preflop;
with Ada.Numerics;
with Ada.Numerics.Discrete_Random;

procedure debug is
   package Rand_Int is new Ada.Numerics.Discrete_Random(Positive);
   gen : Rand_Int.Generator;
   hand, table: T_set;
   c1: T_card;
   game: T_set;
   ch : Float;
begin
        emptySet(game);
      for i in 1..9 loop
         loop
            c1 := randomCard(52);
            exit when not cardInSet(c1, game);
         end loop;
         addToSet(c1, game);
      end loop;

      hand := get_card(game,0) + get_card(game,1);
      table := get_card(game,2)+get_card(game,3);
      --As,Ac hand
   Put_Line("----------------------------------------");
   Put_Line("CARTES DE JEREMY :");
   printCard(get_card(game,0));printCard(get_card(game,1));
   Put_Line("----------------------------------------");
   Put_Line("CARTES DE LA TABLE :");
   printCard(get_card(game,2));printCard(get_card(game,3));
      ch := chancesOfWinning(hand,table);
      Put_Line("CHANCES DE GAGNER :"&ch'Img);
end debug;
