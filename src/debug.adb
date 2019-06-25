with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
with read_preflop; use read_preflop;

procedure debug is
   sample : T_Sample;
   hand, table :T_set;
   c1, c2, c3, c4, c5, c6, c7 : T_card;
   comb : T_combination;
   ch : Float;
begin
   set_rank(c1, 2);
   set_colour(c1, clovers);
   addToSet(c1, hand);

   set_rank(c2, 12);
   set_colour(c2, clovers);
   addToSet(c2, hand);

   initSample(sample, hand);

   set_rank(c3, 8);
   set_colour(c3, spades);
   addToSet(c3, table);
   addToSampleSets(sample, c3);

   set_rank(c4, 8);
   set_colour(c4, spades);
   addToSet(c4, table);
   addToSampleSets(sample, c4);


   set_rank(c5, 6);
   set_colour(c5, spades);
   addToSet(c5, table);
   addToSampleSets(sample, c5);



   comb := getBestCombination(hand+table);
   ch := chancesOfWinning(sample, comb);
   Put_Line(ch'IMG);
   Put_Line(Get_Winning_Chance(c1,c2)'IMG);
end debug;
