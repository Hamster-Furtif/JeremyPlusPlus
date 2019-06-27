with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
with read_preflop; use read_preflop;
with Ada.Numerics;
with Ada.Numerics.Discrete_Random;

procedure debug is
   package Rand_Int is new Ada.Numerics.Discrete_Random(Positive);
   gen : Rand_Int.Generator;
   hand, table : T_set;
   c1, c2, c3, c4, c5, c6, c7 : T_card;
   s1,s2,s3,s4,s5, s6, s7 : T_set;
   ch : Float;
   b: Boolean;
begin
   set_rank(c1, 12);
   set_colour(c1, hearts);
   addToSet(c1, s1);

   set_rank(c2, 12);
   set_colour(c2, diamonds);
   addToSet(c2, s2);
   --Kh,Kd,6h,3s,4h table
   set_rank(c3, 4);
   set_colour(c3, hearts);
   addToSet(c3, s3);

   set_rank(c4, 1);
   set_colour(c4, spades);
   addToSet(c4, s4);

  set_rank(c5, 2);
   set_colour(c5, hearts);
   addToSet(c5, s5);



   set_rank(c6, 13);
   set_colour(c6, spades);
   addToSet(c6, s6);

   set_rank(c7, 13);
   set_colour(c7, clovers);
   addToSet(c7, s7);

   hand := s6 + s7;
   table := s1+s2+s3+s4+s5;
   --As,Ac hand

   ch := chancesOfWinning(hand,table);
   Put_Line(ch'IMG);
   Put_Line(b'Img);
   Put_Line(Get_Winning_Chance(c1,c2)'IMG);
end debug;
